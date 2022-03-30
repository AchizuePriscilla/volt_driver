import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/data/config/base_api.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/shared/custom_back_button.dart';
import 'package:volt_driver/presentation/shared/custom_spacer.dart';
import 'package:volt_driver/presentation/shared/responsive_widget.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/shared/track_order_container.dart';
import 'package:volt_driver/presentation/viewmodels/user_view_model.dart';
import 'package:volt_driver/utils/utils.dart';

class TrackOrderView extends StatefulWidget {
  final OrderModel order;
  const TrackOrderView({required this.order, Key? key}) : super(key: key);

  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderView> {
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;
  late LatLng destinationLocation;
  final Set<Polyline> _polylines = <Polyline>{};
  Completer<GoogleMapController> _controller = Completer();
  Location location = Location();
  void setInitialLocation() {
    var _rxUserVM = context.read<UserVM>();
    var latitude = _rxUserVM.currenLocation.latitude;
    var longitude = _rxUserVM.currenLocation.longitude;
    currentLocation = LatLng(latitude!, longitude!);
    destinationLocation =
        LatLng(widget.order.origin.lat, widget.order.origin.lng);
  }

  @override
  void initState() {
    setInitialLocation();
    super.initState();
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: 16,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(() {
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      _markers.removeWhere((m) => m.markerId.value == 'driverPosition');
      _markers.add(Marker(
          markerId: const MarkerId('driverPosition'),
          infoWindow: const InfoWindow(title: 'My Position'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pinPosition));
    });
  }

  void getCurrentLocationAndUpdatePin() {
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = LatLng(cLoc.latitude!, cLoc.longitude!);
      updatePinOnMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocationAndUpdatePin();
    void showMarker() {
      setState(() {
        _markers.add(Marker(
            markerId: const MarkerId('userPosition'),
            infoWindow: const InfoWindow(title: 'Order Position'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            position: destinationLocation));

        _markers.add(Marker(
            markerId: const MarkerId('driverPosition'),
            infoWindow: const InfoWindow(title: 'My Position'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: currentLocation));
      });
    }

    _getPolyline() async {
      try {
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          BaseApi.getGoogleApiKey(),
          PointLatLng(currentLocation.latitude, currentLocation.longitude),
          PointLatLng(widget.order.origin.lat, widget.order.origin.lng),
          travelMode: TravelMode.driving,
        );
        if (result.points.isNotEmpty) {
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
          setState(() {
            _polylines.add(Polyline(
                color: Palette.buttonColor,
                width: 5,
                jointType: JointType.bevel,
                polylineId: const PolylineId('kPolyline'),
                points: polylineCoordinates));
          });
        }
      } catch (e) {
        AppLogger.logger.d(e);
      }
    }

    return ResponsiveWidget(
        resizeToAvoidBottomInset: false,
        builder: (_, size) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLocation.latitude, currentLocation.longitude),
                      zoom: 12),
                  zoomControlsEnabled: false,
                  trafficEnabled: true,
                  onMapCreated: (controller) async {
                    _controller.complete(controller);
                    showMarker();
                    await _getPolyline();
                  },
                  markers: _markers,
                  polylines: _polylines,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const CustomSpacer(
                      flex: 10,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: CustomBackButton()),
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TrackOrderContainer(
                            order: widget.order,
                          )),
                    ),
                    const CustomSpacer(
                      flex: 10,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}

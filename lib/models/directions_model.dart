import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionModel {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  DirectionModel(
      {required this.bounds,
      required this.polylinePoints,
      required this.totalDistance,
      required this.totalDuration});

  factory DirectionModel.fromMap(Map json) {
    Map<String?, dynamic> _json = Map<String?, dynamic>.from(json['routes'][0]);
    final northeast = _json['bounds']['northeast'];
    final southwest = _json['bounds']['southwest'];
    final bounds = LatLngBounds(
        southwest: LatLng(southwest['lat'], southwest['lng']),
        northeast: LatLng(northeast['lat'], northeast['lng']));

    String distance = '';
    String duration = '';
    final leg = _json['legs'][0];
    distance = leg['distance']['text'];
    duration = leg['duration']['text'];

    return DirectionModel(
        bounds: bounds,
        polylinePoints: PolylinePoints()
            .decodePolyline(_json['overview_polyline']['points']),
        totalDistance: distance,
        totalDuration: duration);
  }
}

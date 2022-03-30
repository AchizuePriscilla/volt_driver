import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volt_driver/data/config/base_api.dart';
import 'package:volt_driver/models/api/get_directions_response.dart';

abstract class DirectionRepository {
  Future<GetDirectionResponse> getDirections(
      {required LatLng origin, required LatLng destination});
}

class DirectionRepoImpl extends BaseApi implements DirectionRepository {
  DirectionRepoImpl(String baseApi) : super(baseApi);

  @override
  Future<GetDirectionResponse> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    var response = await get('', parameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': BaseApi.getGoogleApiKey()
    });

    return GetDirectionResponse.fromMap(response);
  }
}

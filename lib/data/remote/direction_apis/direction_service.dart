import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volt_driver/data/remote/direction_apis/direction_repo.dart';
import 'package:volt_driver/models/api/get_directions_response.dart';

abstract class DirectionService {
  Future<GetDirectionResponse> getDirections(
      {required LatLng origin, required LatLng destination});
}

class DirectionServiceImpl implements DirectionService {
  final DirectionRepository directionRepository;

  DirectionServiceImpl(this.directionRepository);

  @override
  Future<GetDirectionResponse> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    var res = await directionRepository.getDirections(
        origin: origin, destination: destination);

    return res;
  }
}

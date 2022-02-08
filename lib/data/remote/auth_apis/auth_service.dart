import 'package:volt_driver/models/api/api.dart';
import 'package:volt_driver/models/api/login_request.dart';
import 'package:volt_driver/models/api/get_user_response.dart';

abstract class AuthService {
  Future<LoginResponse> logIn(LoginRequest request);
  Future<GetUserResponse> getUser();
}

import 'package:volt_driver/data/config/base_api.dart';
import 'package:volt_driver/models/api/api.dart';
import 'package:volt_driver/models/api/login_request.dart';
import 'package:volt_driver/models/api/get_user_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> logIn(LoginRequest request);
  Future<GetUserResponse> getUser();
  Future<GetUserResponse> getUserById(String id);
}

class AuthRepositoryImpl extends BaseApi implements AuthRepository {
  AuthRepositoryImpl(String baseApi) : super(baseApi);
  static const String login = 'logistics/login';
  static const String user = 'logistics';

  @override
  Future<LoginResponse> logIn(LoginRequest request) async {
    var response = await post(
      login,
      data: request.toMap(),
    );

    return LoginResponse.fromMap(response);
  }

  @override
  Future<GetUserResponse> getUser() async {
    var response = await get(user);
    return GetUserResponse.fromMap(response);
  }

  @override
  Future<GetUserResponse> getUserById(String id) async {
    var response = await get('user/$id');
    return GetUserResponse.fromMap(response);
  }
}

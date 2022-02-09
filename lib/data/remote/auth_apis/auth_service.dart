import 'dart:convert';

import 'package:volt_driver/data/local/local.dart';
import 'package:volt_driver/data/remote/auth_apis/auth_repo.dart';
import 'package:volt_driver/models/api/api.dart';
import 'package:volt_driver/models/api/login_request.dart';
import 'package:volt_driver/models/api/get_user_response.dart';

abstract class AuthService {
  Future<LoginResponse> logIn(LoginRequest request);
  Future<GetUserResponse> getUser();
}


class AuthServiceImpl implements AuthService {
  final AuthRepository authRepo;
  final LocalCache cache;

  AuthServiceImpl({required this.authRepo, required this.cache});

  @override
  Future<LoginResponse> logIn(LoginRequest request) async {
    var res = await authRepo.logIn(request);

    if (res.success) {
      await cache.saveToken(res.token!);
      await cache.cacheUserData(
        value: json.encode(
          res.user!.toJson(),
        ),
      );
    }

    return res;
  }

  @override
  Future<GetUserResponse> getUser() async {
    var res = await authRepo.getUser();
    return res;
  }

}

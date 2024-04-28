// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_system_app/common/errors/exceptions/exception.dart';
import 'package:voting_system_app/common/errors/exceptions/token.expired.exception.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/authentication/data/datasource/user.datasource.dart';
import 'package:voting_system_app/modules/authentication/data/model/activation.model.dart';
import 'package:voting_system_app/modules/authentication/data/model/authentication.model.dart';
import 'package:voting_system_app/modules/authentication/data/model/jwt.model.dart';
import 'package:voting_system_app/modules/authentication/data/model/user.model.dart';

class UserDataSourceImpl implements UserDataSource {
  static final Dio dio = Dio();
  final _getStorage = GetStorage();

  UserDataSourceImpl() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handlers) async {
          options.headers["Accept"] = "application/json";
          String? token = _getStorage.read("access-token");
          options.headers["Authorization"] = 'Bearer $token';
          return handlers.next(options);
        },
        onError: (exception, handler) async {
          if (exception.response!.statusCode == 414 ||
              exception.response!.statusCode == 401) {
            final String? newAccessToken = await getRefreshToken();
            if (newAccessToken != null) {
              dio.options.headers["Authorization"] = 'Bearer $newAccessToken';
              return handler.resolve(await dio.fetch(exception.requestOptions));
            } else {
              GetStorage().erase();
              return handler.next(exception);
            }
          }
        },
      ),
    );
    serviceLocator.registerLazySingleton<Dio>(() => dio);
  }

  @override
  Future<bool> addUser(UserModel user) async {
    try {
      final resp = await Dio().post(
          "${AppConsants.apiUrl}authentication/register",
          data: user.toJson());
      if (resp.statusCode == 200) {
        return true;
      } else {
        throw ServerException(errorMessage: resp.data);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
    return false;
  }

  @override
  Future<bool> activateUserAccount(ActivationModel activationModel) async {
    final resp = await Dio().post(
        "${AppConsants.apiUrl}authentication/activation",
        data: activationModel.toJson());
    if (resp.statusCode == 200) {
      return true;
    } else if (resp.statusCode == 406) {
      throw ServerException(errorMessage: resp.data);
    } else {
      throw Exception(resp.data);
    }
  }

  @override
  Future<JwtModel> loginUser(AuthenticationModel auth) async {
    final resp = await Dio()
        .post("${AppConsants.apiUrl}authentication/login", data: auth.toJson());

    if (resp.statusCode == 200) {
      return JwtModel.fromJson(resp.data);
    } else if (resp.statusCode == 401) {
      throw ServerException(errorMessage: "Bad credentials");
    } else if (resp.statusCode == 414) {
      throw TokenExpiredException(message: resp.data);
    } else {
      throw Exception(resp.data);
    }
  }

  getRefreshToken() async {
    try {
      final refreshToken = _getStorage.read("refresh-token");

      AuthenticationModel auth = AuthenticationModel(
        grantType: "refreshToken",
        username: "111",
        password: "1111",
        withRefreshToen: true,
        refreshToken: refreshToken,
      );

      final resp = await Dio().post(
        "${AppConsants.apiUrl}authentication/login",
        data: auth.toJson(),
      );

      if (resp.statusCode == 200) {
        JwtModel jwt = JwtModel.fromJson(resp.data);
        await _getStorage.write("refresh-token", jwt.refreshToken);
      } else if (resp.statusCode == 401) {
        GetStorage().erase();
        return null;
      } else if (resp.statusCode == 414) {
        print("Wow");
      }
    } catch (err) {
      print("Error ::  $err");
    }
  }
}

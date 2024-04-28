// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:voting_system_app/common/errors/failueres/failure.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/authentication.dart';
import 'package:voting_system_app/modules/authentication/domain/usecase/loginuser.useecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<LoginVisiblePasswordBtnClickedEvent>(
        loginVisiblePasswordBtnClickedEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
  }

  FutureOr<void> loginInitialEvent(
      LoginInitialEvent event, Emitter<LoginState> emit) {
    emit(LoginLoadedSuccessState());
  }

  FutureOr<void> loginVisiblePasswordBtnClickedEvent(
      LoginVisiblePasswordBtnClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginVisiblePasswordBtnClickedState());
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    final getStorage = GetStorage();
    final LoginUserUsecase loginUseCase = serviceLocator<LoginUserUsecase>();
    Authentication auth1 = Authentication(
      username: event.email,
      password: event.password,
      withRefreshToen: false,
      grantType: "password",
    );

    final jwt = await loginUseCase.execute(auth1);

    await jwt.fold(
      (l) {
        if (l is ServerFailure) {
          emit(LoginWithBadCredentialsState());
          return;
        } else if (l is TokenExpiredFailure) {
          emit(LoginRefreshTokenExpireActionState());
          return;
        }
      },
      (r) async {
        Authentication auth = Authentication(
          username: "11",
          password: "22",
          withRefreshToen: true,
          grantType: "refreshToken",
          refreshToken: r.accessToken,
        );
        print("Auth2 :::${auth.toString()}");
        final jwt2 = await loginUseCase.execute(auth);

        await jwt2.fold(
          (l) {
            if (l is TokenExpiredFailure) {
              emit(LoginRefreshTokenExpireActionState());
            } else if (l is ServerFailure) {
              emit(LoginWithBadCredentialsState());
            } else {
              print("ELSE");
            }
          },
          (r) async {
            String? jwt = r.accessToken;
            Map<String, dynamic> decodedToken = JwtDecoder.decode(jwt!);
            emit(LoginLoadingState());
            await getStorage.write("loged-user", decodedToken['sub']);
            await getStorage.write("access-token", r.accessToken);
            await getStorage.write("refresh-token", r.refreshToken);
            emit(LoginSucessState());
          },
        );
      },
    );
  }
}

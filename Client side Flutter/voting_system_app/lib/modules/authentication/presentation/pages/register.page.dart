// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_system_app/common/utils/constants/english.expressions.dart';
import 'package:voting_system_app/modules/authentication/domain/entities/user.dart';
import 'package:voting_system_app/modules/authentication/presentation/controllers/register_bloc/register_bloc.dart';
import 'package:voting_system_app/modules/authentication/presentation/pages/login.page.dart';
import 'package:voting_system_app/modules/authentication/presentation/pages/verficationcode.page.dart';
import 'package:voting_system_app/modules/authentication/presentation/widgets/button.custom.dart';
import 'package:voting_system_app/modules/authentication/presentation/widgets/custom.emptybutton.dart';
import 'package:voting_system_app/modules/authentication/presentation/widgets/textfiled.custom.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();
  final locationController = TextEditingController();
  bool isVisible = false;
  bool isVerifPassVisible = false;

  void initState() {
    _registerBloc.add(RegisterInitialEvent());
  }

  final _formKey = GlobalKey<FormState>();
  final RegisterBloc _registerBloc = RegisterBloc();

  bool passVisible = true;
  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          bloc: _registerBloc,
          listenWhen: (previous, current) => current is RegisterActionState,
          buildWhen: (previous, current) => current is! RegisterActionState,
          listener: (context, state) {
            if (state is RegisterNavigateToVerficationCodePageActionState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerficationCodePage()));
            }
          },
          builder: (context, state) {
            if (state is RegisterLoadedSuccessState ||
                state is RegisterVisiblePasswordBtnClickedState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          height: MediaQuery.of(context).size.height * .17,
                          image: const AssetImage(
                              "assets/auth-assets/register.png"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .004,
                        ),
                        const Text(
                          EnglishExpressions.registerExpression,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                        MyTextFiled(
                          controller: userNameController,
                          hintText: "username",
                          validator: _validateUserName,
                        ),
                        MyTextFiled(
                          validator: _validateEmail,
                          controller: emailController,
                          hintText: "email",
                        ),
                        MyTextFiled(
                            controller: passwordController,
                            hintText: "password",
                            validator: _validatePassword,
                            obscure: !isVisible,
                            iconButton: IconButton(
                                onPressed: () {
                                  isVisible = !isVisible;
                                  _registerBloc.add(
                                      RegisterVisiblePasswordBtnClickedEvent());
                                },
                                icon: Icon(
                                  !isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ))),
                        MyTextFiled(
                            controller: retypePasswordController,
                            hintText: "retype-password",
                            obscure: !isVerifPassVisible,
                            validator: _validateVerificationPassword,
                            iconButton: IconButton(
                                onPressed: () {
                                  isVerifPassVisible = !isVerifPassVisible;
                                  _registerBloc.add(
                                      RegisterVisiblePasswordBtnClickedEvent());
                                },
                                icon: Icon(
                                  !isVerifPassVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ))),
                        MyTextFiled(
                          validator: _validateLocation,
                          controller: locationController,
                          hintText: "location",
                        ),
                        //SignUp Button
                        MyCustomeButton(
                            textButton: "Sign up", onTap: _handleSignUp),
                        //Already have an account ? login
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Alread have an account ? ",
                              style: TextStyle(fontSize: 17),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => LoginPage()));
                              },
                              child: Text(
                                "Login now",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .001,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.grey[500],
                              )),
                              const SizedBox(width: 10),
                              const Text("OR",
                                  style: TextStyle(color: Colors.black)),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Divider(
                                color: Colors.grey[500],
                              )), // Fills available space with a line
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .001,
                        ),
                        const BorderedButton(
                            btnText: "Sign up with google",
                            imageUrl: "assets/auth-assets/google.png"),
                        const BorderedButton(
                            btnText: "Sign up with google",
                            imageUrl: "assets/auth-assets/github.png"),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is RegisterLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                ),
              );
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          },
        ),
      ),
    );
  }

  void _handleSignUp() async {
    User user = User(
      id: 0,
      username: userNameController.text,
      password: passwordController.text,
      location: locationController.text,
      memeberSince: DateTime.now(),
      email: emailController.text,
    );

    if (_formKey.currentState!.validate()) {
      _registerBloc.add(RegisterSubmitFormButtonClickedEvent(user: user));
    }
  }

  String? _validateUserName(String? value) {
    if (value == null) {
      return "username is required*";
    } else if (value.isEmpty) {
      return "username is required*";
    } else if (value.length < 3) {
      return "4 characters at least";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null) {
      return "password is required*";
    } else if (value.isEmpty) {
      return "password is required*";
    } else if (value.length < 6) {
      return "password must contain 6 characters at least";
    }
    return null;
  }

  String? _validateVerificationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "password is required*";
    } else if (value != passwordController.text) {
      return "not valid";
    }
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null) {
      return "location is required*";
    } else if (value.isEmpty) {
      return "location is required*";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r'^\S+@\S+\.\S+$');
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}

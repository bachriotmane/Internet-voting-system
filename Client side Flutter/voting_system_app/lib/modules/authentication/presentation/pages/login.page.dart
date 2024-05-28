// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_system_app/common/utils/constants/english.expressions.dart';
import 'package:voting_system_app/modules/authentication/presentation/controllers/login_bloc/login_bloc.dart';
import 'package:voting_system_app/modules/authentication/presentation/pages/register.page.dart';
import 'package:voting_system_app/modules/authentication/presentation/widgets/button.custom.dart';
import 'package:voting_system_app/modules/authentication/presentation/widgets/custom.emptybutton.dart';
import 'package:voting_system_app/modules/authentication/presentation/widgets/textfiled.custom.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/routing.page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;

  void initState() {
    _loginBloc.add(LoginInitialEvent());
  }

  final _formKey = GlobalKey<FormState>();
  final LoginBloc _loginBloc = LoginBloc();

  bool passVisible = true;
  @override
  Widget build(BuildContext context) {
    initState();
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            bloc: _loginBloc,
            listenWhen: (previous, current) => current is LoginActionState,
            buildWhen: (previous, current) => current is! LoginActionState,
            listener: (context, state) {
              if (state is LoginWithBadCredentialsState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Bad credentials"),
                  ),
                );
              } else if (state is LoginSucessState) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const RoutingPage(),
                    ));
              } else if (state is LoginRefreshTokenExpireActionState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Token Expired"),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoadedSuccessState ||
                  state is LoginVisiblePasswordBtnClickedState) {
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
                            image:
                                const AssetImage("assets/icons/app_logo.png"),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            EnglishExpressions.loginExpression,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .07,
                          ),
                          MyTextFiled(
                            validator: _validateEmail,
                            controller: emailController,
                            hintText: "username",
                          ),
                          MyTextFiled(
                              controller: passwordController,
                              hintText: "password",
                              validator: _validatePassword,
                              obscure: !isVisible,
                              iconButton: IconButton(
                                  onPressed: () {
                                    isVisible = !isVisible;
                                    _loginBloc.add(
                                        LoginVisiblePasswordBtnClickedEvent());
                                  },
                                  icon: Icon(
                                    !isVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ))),
                          InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Forgot password?",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          MyCustomeButton(
                              textButton: "Login", onTap: _handleLogin),
                          //Already have an account ? login
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .07),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Not a member ? ",
                                style: TextStyle(fontSize: 17),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => RegisterPage()));
                                },
                                child: Text(
                                  "Register now",
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
              } else if (state is LoginLoadingState) {
                return const Center(
                  child: Text("Loading"),
                );
              } else {
                return const Center(
                  child: Text("Error"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _loginBloc.add(
        LoginButtonClickedEvent(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  String? _validatePassword(String? value) {
    if (value == null) {
      return "password is required*";
    } else if (value.isEmpty) {
      return "password is required*";
    } else if (value.length < 2) {
      return "password must contain 6 characters at least";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || value.length < 2) {
      return 'Enter a valid username address';
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:voting_system_app/modules/authentication/presentation/controllers/verfication_bloc/verfication_bloc.dart';
import 'package:voting_system_app/modules/authentication/presentation/pages/login.page.dart';
import 'package:voting_system_app/modules/authentication/presentation/widgets/button.custom.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class VerficationCodePage extends StatelessWidget {
  final VerficationBloc _verficationBloc = VerficationBloc();
  bool isValid = true;

  void initState() {
    _verficationBloc.add(VeficationInitialEvent());
  }

  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  TextEditingController c5 = TextEditingController();
  TextEditingController c6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initState();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: BlocConsumer<VerficationBloc, VerficationState>(
              bloc: _verficationBloc,
              listenWhen: (previous, current) =>
                  current is VerficationActionState,
              buildWhen: (previous, current) =>
                  current is! VerficationActionState,
              listener: (context, state) {
                if (state is VerficationNavigateToLoginPageActionState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Your account activated Succesfuly!")));
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (c) => LoginPage()));
                }
                if (state is VerficationErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMsg),
                      backgroundColor: Colors.red,
                    ),
                  );
                  isValid = false;
                  _verficationBloc.add(VeficationInitialEvent());
                }
              },
              builder: (context, state) {
                if (state is VerficationLoadedSucessState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email,
                              size: 36, color: Theme.of(context).primaryColor),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .05,
                          ),
                          const Text(
                            "Verfication Code",
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        child: Text(
                          "Enter your verification code that we sent you through your e-mail",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        child: Card(
                            child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildCodeBox(c1, isValid),
                                _buildCodeBox(c2, isValid),
                                _buildCodeBox(c3, isValid),
                                _buildCodeBox(c4, isValid),
                                _buildCodeBox(c5, isValid),
                                _buildCodeBox(c6, isValid),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .5),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.timer,
                                        size: 35, color: Colors.grey[700]),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .04,
                                    ),
                                    Countdown(
                                      seconds: 59,
                                      build: (b, t) => Text(
                                        t.toString(),
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      onFinished: () {
                                        isValid = false;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "The code is expired try to get new Code!"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        _verficationBloc
                                            .add(VeficationInitialEvent());
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .03),
                                MyCustomeButton(
                                  textButton: "Submit",
                                  onTap: () {
                                    String code = c1.text +
                                        c2.text +
                                        c3.text +
                                        c4.text +
                                        c5.text +
                                        c6.text;
                                    _verficationBloc.add(
                                        VerficationActivateAccountEvent(
                                            code: code));
                                  },
                                )
                              ],
                            ),
                          ],
                        )),
                      )
                    ],
                  );
                }
                return const Text("Otmane");
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeBox(TextEditingController c, bool isValid) {
    return Container(
      width: 40.0,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border.all(color: isValid ? Colors.black54 : Colors.red),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextField(
        controller: c,
        textInputAction: TextInputAction.next,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

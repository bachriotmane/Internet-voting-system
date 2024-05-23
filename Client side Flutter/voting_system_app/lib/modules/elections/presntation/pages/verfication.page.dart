// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:voting_system_app/modules/authentication/presentation/widgets/button.custom.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/presntation/blocs/verfication_bloc/verification_bloc.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/room.page.dart';

class VerificationMemeberPage extends StatelessWidget {
  final VerificationBloc _verficationBloc = VerificationBloc();
  Room room;
  bool isValid = true;
  VerificationMemeberPage({
    Key? key,
    required this.room,
  }) : super(key: key);

  void initState() {
    _verficationBloc.add(VerficationInitialEvent());
  }

  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();

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
            child: BlocConsumer<VerificationBloc, VerificationState>(
              bloc: _verficationBloc,
              listenWhen: (previous, current) =>
                  current is VerificationActionState,
              buildWhen: (previous, current) =>
                  current is! VerificationActionState,
              listener: (context, state) {
                if (state is VerificationNavigateToRoomPageActionState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("You are in the room")));
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c) => RoomPage(room: room)));
                }
                if (state is VerificationBadCodeActionState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Incorrect code try later!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is VerificationSuccessState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.security,
                              size: 36, color: Theme.of(context).primaryColor),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .05,
                          ),
                          Text(
                            room.roomTitle,
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
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .5),
                            Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .03),
                                MyCustomeButton(
                                  textButton: "Submit",
                                  onTap: () {
                                    String code =
                                        c1.text + c2.text + c3.text + c4.text;
                                    _verficationBloc.add(
                                        VerificationSubmitButtonClickedEvent(
                                            providedCode: code, room: room));
                                  },
                                )
                              ],
                            ),
                          ],
                        )),
                      )
                    ],
                  );
                } else if (state is VerificationLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is VerificationErrorState) {
                  return Text(state.message,
                      style: TextStyle(color: Colors.red));
                }
                return const Text("Unknown state");
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

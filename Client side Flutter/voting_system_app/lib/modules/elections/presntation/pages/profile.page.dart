import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_system_app/common/utils/constants/colors.constants.dart';
import 'package:voting_system_app/modules/authentication/presentation/pages/login.page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              // height: 300,
              child: Image.asset('assets/profile_page/circles.png'),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(40, 20),
                    bottomRight: Radius.elliptical(40, 20)),
                color: const Color.fromARGB(255, 3, 112, 201),
              ),
            ),
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/profile_page/profile_page.jpg',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Abelkarim idrissi",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "idrissiabdelkarim@gmail.com",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: 30,
              right: 30,
              child: Container(
                  // height: 400,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      _buildRowInfo(context, "Username", "18"),
                      _buildRowInfo(context, "First Name", "18"),
                      _buildRowInfo(context, "Last Name", "18"),
                      _buildRowInfo(context, "Email", "idrissi@gmail.com"),
                      _buildRowInfo(context, "Phone Number", "066-657-000"),
                      _buildRowInfo(context, "CIN", "W0000"),
                      _buildRowInfo(context, "Age", "18"),
                      GestureDetector(
                        onTap: () {
                          GetStorage().erase().then((value) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Log out",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  )),
            ),
            //   Positioned(
            //       left: 30,
            //       right: 30,
            //       bottom: 60,
            //       child: Container(
            //           child: TextButton(
            //         onPressed: () {
            //           // Action to perform when the button is pressed
            //         },
            //         child: Text(
            //           'EDIT PROFILE',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //         style: TextButton.styleFrom(
            //           backgroundColor: AppColor.principaleLightColor,
            //           minimumSize: Size(200, 50), // Button size
            //         ),
            //       )))
          ],
        ),
      ),
    );
  }

  _buildRowInfo(context, String info, String value) {
    return Container(
      child: Row(
        children: [
          Text(
            info,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Roboto',
              // fontWeight: FontWeight.bold,
              color: AppColor.principaleLightColor,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 0.5,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}

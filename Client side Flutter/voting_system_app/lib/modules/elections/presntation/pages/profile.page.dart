import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/common/utils/constants/app.constants.dart';
import 'package:voting_system_app/modules/authentication/presentation/pages/login.page.dart';
import 'package:voting_system_app/modules/elections/domain/entities/user.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/row_user_info.dart';
import 'package:dio/dio.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _getStorage = GetStorage();
  UserInfo userInfo = UserInfo(
      username: '',
      firstName: '',
      lastName: '',
      email: '',
      phoneNumber: '',
      CIN: '',
      age: '');

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    Dio _dio = serviceLocator<Dio>();
    try {
      final response = await _dio
          .get("${AppConstants.apiUrl}users/${_getStorage.read("loged-user")}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        print(response.data.toString());
        setState(() {
          userInfo.username = data['username'].toString();
          userInfo.firstName = data['nom'].toString();
          userInfo.lastName = data['prenom'].toString();
          userInfo.email = data['email'].toString();
          // print(userInfo.email);
          userInfo.phoneNumber = data['phoneNumber'].toString();
          userInfo.CIN = data['CIN'].toString();
          userInfo.age = data['age'].toString();
        });
      } else {
        throw Exception('Failed to load user info');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
                      "${userInfo.firstName} ${userInfo.lastName}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      userInfo.email,
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      RowUserProfile(
                          info: "Username", value: userInfo.username),
                      RowUserProfile(
                          info: "First Name", value: userInfo.firstName),
                      RowUserProfile(
                          info: "Last Name", value: userInfo.lastName),
                      RowUserProfile(info: "Email", value: userInfo.email),
                      RowUserProfile(
                          info: "Phone Number", value: userInfo.phoneNumber),
                      RowUserProfile(info: "CIN", value: userInfo.CIN),
                      RowUserProfile(info: "Age", value: userInfo.age),
                      SizedBox(height: 15),
                    ],
                  )),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    GetStorage().erase().then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Image.asset(
                      'assets/profile_page/logout.png',
                      color: Colors.white,
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
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
}

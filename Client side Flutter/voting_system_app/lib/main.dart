import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/common/themes/light.theme.dart';
import 'package:voting_system_app/modules/authentication/presentation/pages/login.page.dart';
import 'package:voting_system_app/modules/elections/home.page.dart';

final getStorage = GetStorage();
void main() async {
  init();
  await GetStorage.init();
  await getStorage.erase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: lightTheme,
      home: getStorage.read("access-token") == null
          ? LoginPage()
          : const HomePage(),
    );
  }
}

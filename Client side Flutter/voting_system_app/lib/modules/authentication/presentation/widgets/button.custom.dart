// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyCustomeButton extends StatelessWidget {
  final String textButton;
  void Function()? onTap;
  MyCustomeButton({super.key, required this.textButton, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * .06,
        width: MediaQuery.of(context).size.width * .90,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          textButton,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final IconButton? iconButton;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const MyTextFiled(
      {Key? key,
      required this.hintText,
      this.obscure = false,
      required this.controller,
      this.iconButton,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      // padding: const EdgeInsets.all(15),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscure,
        cursorColor: Theme.of(context).primaryColor,
        style: const TextStyle(fontSize: 17, height: 1.03),
        decoration: InputDecoration(
          suffixIcon: iconButton,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusColor: Theme.of(context).primaryColor,
          hintStyle: TextStyle(color: Colors.grey[600]),
          fillColor: Theme.of(context).hintColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

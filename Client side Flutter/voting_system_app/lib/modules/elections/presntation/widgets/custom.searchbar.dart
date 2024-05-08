import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyCustomSearchBar extends StatelessWidget {
  const MyCustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 20, color: Colors.grey[800]),
      decoration: InputDecoration(
          prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass,
              size: 18, color: Colors.grey[500]),
          fillColor: Colors.grey[200],
          border: InputBorder.none,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 18)),
    );
  }
}

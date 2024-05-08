import 'package:flutter/material.dart';

class CustomDivisionText extends StatelessWidget {
  const CustomDivisionText({super.key, required this.divisionName, this.onTap});
  final String divisionName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            divisionName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Text(
              "See all",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        )
      ],
    );
  }
}

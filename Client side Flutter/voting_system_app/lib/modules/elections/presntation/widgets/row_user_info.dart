import 'package:flutter/material.dart';
import 'package:voting_system_app/common/utils/constants/colors.constants.dart';

class RowUserProfile extends StatelessWidget {
  final String info;
  final String value;
  const RowUserProfile({super.key, required this.info, required this.value});

  @override
  Widget build(BuildContext context) {
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

import 'package:flutter/material.dart';

class BorderedButton extends StatelessWidget {
  final String btnText;
  final String imageUrl;
  const BorderedButton(
      {super.key, required this.btnText, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: MediaQuery.of(context).size.height * .03,
            image: AssetImage(imageUrl),
          ),
          const SizedBox(width: 10),
          Text(
            btnText,
            style: TextStyle(fontSize: 21),
          )
        ],
      ),
    );
  }
}

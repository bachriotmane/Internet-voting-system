import 'package:flutter/material.dart';

class CustomCategoryWidget extends StatelessWidget {
  const CustomCategoryWidget({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
    this.onTap,
  });
  final String categoryName;
  final IconData categoryIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        width: MediaQuery.of(context).size.width / 4.7,
        height: MediaQuery.of(context).size.height / 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: 55,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                categoryIcon,
                color: Colors.black87,
                size: 22,
              ),
            ),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

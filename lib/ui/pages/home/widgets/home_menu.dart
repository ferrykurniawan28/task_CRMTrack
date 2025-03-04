import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final Image icon;
  final String title;
  final Function()? onTap;
  final Color backgroundColor;
  final double borderRadius;
  final TextStyle? textStyle;

  const CardMenu({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.backgroundColor = const Color.fromRGBO(249, 250, 251, 1),
    this.borderRadius = 7.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Center(
                child: icon,
              ),
            ),
            spacerHeight(4),
            Text(
              title,
              style: textStyle ??
                  const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

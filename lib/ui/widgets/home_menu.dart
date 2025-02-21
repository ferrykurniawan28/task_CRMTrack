import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final Image icon;
  final String title;
  Function()? onTap;
  CardMenu({super.key, required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 250, 251, 1),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: icon,
              ),
            ),
            spacerHeight(4),
            Text(
              title,
              style: TextStyle(
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

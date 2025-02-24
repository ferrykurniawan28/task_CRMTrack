import 'package:crm_track/helpers/helpers.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      Image.asset('assets/images/Avatar.png').image,
                  radius: 32,
                ),
                spacerWidth(14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Kim Jong Un',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    const Text(
                      'Staff',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          spacerHeight(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                cardProfile('assets/icon/person.png', 'Biodata', () {}),
                spacerHeight(10),
                cardProfile(
                    'assets/icon/file-text.png', 'Terms & Conditions', () {}),
                spacerHeight(10),
                cardProfile('assets/icon/exclamation-octagon.png',
                    'Privacy Policy', () {}),
                spacerHeight(10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/auth/login');
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icon/box-arrow-left.png',
                          color: Colors.black,
                          height: 24,
                          width: 24,
                        ),
                        spacerWidth(23),
                        Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget cardProfile(String img, String title, void Function()? onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    child: Row(
      children: [
        Image.asset(
          img,
          color: Colors.black,
          height: 24,
          width: 24,
        ),
        spacerWidth(23),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

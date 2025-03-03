import 'dart:async';
import 'package:crm_track/ui/pages/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../helpers/helpers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progress = 0.0;
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    startDownload();
  }

  void startDownload() {
    setState(() {
      isDownloading = true;
      progress = 0.0;
    });

    print('LOADING START');

    Timer.periodic(
      const Duration(milliseconds: 200),
      (timer) {
        setState(() {
          if (progress < 1.0) {
            progress += 0.05;
            print(progress.toString());
          }
          if (progress >= 1.0) {
            print('LOADING SELESAI');
            timer.cancel();
            isDownloading = false;
            Modular.to.navigate('/auth/login');
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromRGBO(255, 209, 209, 1),
              Color.fromRGBO(
                255,
                184,
                184,
                1,
              )
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            spacerHeight(300),
            Center(
              child: Image.asset(
                'assets/images/CRMTrack.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: SizedBox(
                width: 150,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white,
                  minHeight: 2,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                isDownloading ? 'Loading...' : 'Loaded',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Image.asset('assets/images/Logo Zegen.png'),
            ),
          ],
        ),
      ),
    );
  }
}

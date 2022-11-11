import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    const duration = Duration(milliseconds: 2800);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/navbar');
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: Container(
        child: Lottie.asset('assets/icons/x-logo.json'),
      ),
    );
  }
}

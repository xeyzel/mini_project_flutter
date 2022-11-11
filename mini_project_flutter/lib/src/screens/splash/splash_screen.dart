import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_project_flutter/src/screens/home/navbar_setter/home_navbar.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _redirect();
  }

  _redirect() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    if (mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeNavbar(),
          ));
    }
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
        child: Lottie.asset('assets/icons/x-logo.json', key: const Key('logo')),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingMax extends StatelessWidget {
  const LoadingMax({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/icons/sports-loading.json',
        width: 80,
      ),
    );
  }
}

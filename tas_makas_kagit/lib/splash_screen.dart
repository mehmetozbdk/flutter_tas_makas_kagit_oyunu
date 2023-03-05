import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tas_makas_kagit/home_page.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({super.key});

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FadeInUp(child: const HomePage()),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/images/unnamed.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

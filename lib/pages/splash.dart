import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:capstone_restaurant/data.dart';
import 'package:capstone_restaurant/pages/home/home.dart';
import 'package:capstone_restaurant/pages/login/onboarding_page.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  // final bool isLogin;
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    fetchDataAndMenu();
  }

  Future<void> fetchDataAndMenu() async {
    final prefs = await SharedPreferences.getInstance();
    bool loginStatus = await prefs.getBool('isLogin') ?? false;
    await fetchDataFromSharedPreferences();
    setState(() {
      isLogin = loginStatus;
    });
    print(loginStatus);
    print(localUserData);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        'assets/images/altaLogo.png',
        width: 300,
      ),
      splashIconSize: double.infinity,
      backgroundColor: primary3,
      nextScreen: isLogin ? const Home(setIdx: 0) : const OnboardingPage(),
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000,
    );
  }
}

import 'package:capstone_restaurant/logic/login/login_logic.dart';
import 'package:capstone_restaurant/pages/login/register_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool passwordVisible = true;

  @override
  void dispose() {
    emailInput.dispose();
    passwordInput.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: showLoginPage());
  }

  Widget showLoginPage() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login/loginBg.png'),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter)),
        child: Column(
          children: [
            const SizedBox(height: 172),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: primary2,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(56))),
              child: Column(
                children: [
                  const SizedBox(height: 11),
                  Image.asset('assets/images/login/handle.png'),
                  const SizedBox(height: 27),
                  Image.asset('assets/images/altaLogo.png', width: 105),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selamat datang!',
                              style: poppins.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 24)),
                          Text('Yuk, coba berbagai menu kami',
                              style: poppins.copyWith(color: primary4)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email',
                              style: poppins.copyWith(
                                  fontSize: 16, color: outline)),
                          userInput(emailInput),
                          const SizedBox(height: 16),
                          Text('Password',
                              style: poppins.copyWith(
                                  fontSize: 16, color: outline)),
                          userPasswordInput(passwordInput),
                          const SizedBox(height: 8),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         PageTransition(
                          //             child: const ResetPassword(),
                          //             type: PageTransitionType.fade));
                          //     debugPrint('lupa password tertekan');
                          //   },
                          //   child: Text(
                          //     'Lupa Password?',
                          //     style: poppins.copyWith(
                          //         fontSize: 12, color: outline),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      userInputCheck(
                          context, emailInput.text, passwordInput.text);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary4,
                        borderRadius: BorderRadius.circular(37),
                      ),
                      width: 335,
                      height: 48,
                      child: Center(
                        child: Text(
                          'Masuk',
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: primary2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun?',
                        style: poppins.copyWith(fontSize: 12, color: outline),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const RegisterPage(),
                                  type: PageTransitionType.fade));
                          debugPrint('Buat akun tertekan');
                        },
                        child: Text(
                          'Buat akun baru',
                          style: poppins.copyWith(fontSize: 12, color: orange),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 24),
                  // SizedBox(
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         'Atau',
                  //         style: poppins.copyWith(fontSize: 16),
                  //       ),
                  //       const SizedBox(height: 24),
                  //       loginWithSocial('assets/images/login/facebook.png',
                  //           'Login dengan Facebook', facebookBlue),
                  //       const SizedBox(height: 16),
                  //       loginWithSocial('assets/images/login/google.png',
                  //           'Login dengan Google', googleBlue),
                  //       const SizedBox(height: 67),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userInput(controller) {
    return TextField(
      onTap: () {
        setState(() {
          emailInput.text = 'user@gmail.com';
        });
      },
      focusNode: emailFocusNode,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      style: poppins.copyWith(fontSize: 16),
    );
  }

  Widget userPasswordInput(controller) {
    return TextFormField(
      onTap: () {
        setState(() {
          passwordInput.text = 'User1234';
        });
      },
      focusNode: passwordFocusNode,
      textInputAction: TextInputAction.send,
      onFieldSubmitted: (value) {
        userInputCheck(context, emailInput.text, passwordInput.text);
      },
      controller: controller,
      obscureText: passwordVisible,
      style: poppins.copyWith(fontSize: 16),
      decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: outline,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              })),
    );
  }
}

Widget loginWithSocial(img, label, bgColor) {
  return GestureDetector(
    onTap: () {
      debugPrint('$label ditekan');
    },
    child: Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(37),
      ),
      width: 335,
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(img),
            Expanded(
              child: Center(
                child: Text(label,
                    style: poppins.copyWith(fontSize: 14, color: primary2)),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

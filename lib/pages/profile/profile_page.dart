import 'package:capstone_restaurant/data.dart';
import 'package:capstone_restaurant/pages/login/onboarding_page.dart';
import 'package:capstone_restaurant/pages/profile/my_account_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      body: accPage(),
    );
  }

  showAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Text(
            "Profil Saya",
            style: poppins.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget accPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 20, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            'assets/images/home/accPage/avatar.png')),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(localUserData[0],
                                  style: poppins.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20)),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: const AccPage(),
                                          type: PageTransitionType.fade));
                                  debugPrint('edit tertekan');
                                },
                                child: Image.asset(
                                    'assets/images/icons/edit.png',
                                    width: 20),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Text(localUserData[1],
                              style: poppins.copyWith(
                                  color: outline, fontSize: 14)),
                          Text(localUserData[2],
                              style: poppins.copyWith(
                                  color: outline, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 33, top: 35, bottom: 46),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Akun saya',
                  style: poppins.copyWith(fontSize: 16, color: outline),
                ),
                SizedBox(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: accMenu.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      String title = accMenu[index][0];
                      String subtitle = accMenu[index][1];
                      String img = accMenu[index][2];
                      Widget route = accMenu[index][3];
                      return accMenuMaker(context, title, subtitle, img, route);
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Lainnya',
                  style: poppins.copyWith(fontSize: 16, color: outline),
                ),
                SizedBox(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: accExtraMenu.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      String title = accExtraMenu[index][0];
                      String subtitle = accExtraMenu[index][1];
                      String img = accExtraMenu[index][2];
                      Widget route = accExtraMenu[index][3];
                      return accMenuMaker(context, title, subtitle, img, route);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: outline))),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/icons/accPage/logout.png',
                        width: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Keluar',
                                    style: poppins.copyWith(fontSize: 16)),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    bool isExit = await exitDialog();
                                    if (isExit) {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.remove('isLogin');
                                      await prefs.remove('userData');
                                      logOut();
                                    }
                                    debugPrint('Keluar tertekan');
                                  },
                                  child: RotatedBox(
                                    quarterTurns: 90,
                                    child: Image.asset(
                                        'assets/images/icons/backButton.png',
                                        opacity:
                                            const AlwaysStoppedAnimation(.8)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  logOut() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: const OnboardingPage(), type: PageTransitionType.fade));
  }

  Future<bool> exitDialog() async {
    return await showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/icons/closeW.png',
                        color: primary4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Kamu yakin ingin keluar?',
                    style: poppins.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kalau kamu yakin ingin keluar,\n silakan klik "keluar" di bawah ini ya.',
                    style: poppins.copyWith(color: outline, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                      debugPrint('Ubah Password tertekan');
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
                          'Keluar',
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: primary2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            )));
  }
}

Widget accMenuMaker(context, title, subtitile, titleIcon, route) {
  return Container(
    decoration:
        BoxDecoration(border: Border(bottom: BorderSide(color: outline))),
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          titleIcon,
          width: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title, style: poppins.copyWith(fontSize: 16)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: route, type: PageTransitionType.fade));

                      debugPrint('$title tertekan');
                    },
                    child: RotatedBox(
                      quarterTurns: 90,
                      child: Image.asset('assets/images/icons/backButton.png',
                          opacity: const AlwaysStoppedAnimation(.8)),
                    ),
                  ),
                ],
              ),
              Text(subtitile, style: poppins.copyWith(fontSize: 14))
            ],
          ),
        )
      ],
    ),
  );
}

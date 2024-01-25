// rachel

import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/help/help_page.dart';
import 'package:capstone_restaurant/pages/home/home_page.dart';
import 'package:capstone_restaurant/pages/order/order_page.dart';
import 'package:capstone_restaurant/pages/profile/profile_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final int setIdx;
  const Home({super.key, required this.setIdx});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDataAndMenu();
    int setIdx = widget.setIdx;
    setState(() {
      currentPageIndex = setIdx;
    });
  }

  Future<void> fetchDataAndMenu() async {
    setState(() {
      isLoading = true;
    });
    final menuProvider = Provider.of<MenuDataProvider>(context, listen: false);
    fetchDataFromSharedPreferences();
    await menuProvider.getMenuAll();

    setState(() {
      isLoading = false;
    });
  }

  void changePageIndex(int newIndex) {
    setState(() {
      currentPageIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading?Container(
            color: primary3,
            child: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: primary4,
                  strokeWidth: 10,
                ),
              ),
            ),
          ):Scaffold(
          // extendBody: true,
          body: <Widget>[
            HomePage(changePageIndex: changePageIndex),
            const OrderPage(),
            const HelpPage(route: true),
            const ProfilePage()
          ][currentPageIndex],
          bottomNavigationBar: currentPageIndex == 2 ? null : botNav(),
        )
    );
  }

  Widget botNav() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(65),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1)
          ]),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          elevation: 15,
          // shadowColor: Colors.black,
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.selected)
                    ? poppins.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: primary4)
                    : poppins.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: outline),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: <Widget>[
            navDest('assets/images/icons/home.png', primary4, 'Beranda'),
            navDest('assets/images/icons/pesanan.png', primary4, 'Pesanan'),
            navDest('assets/images/icons/bantuan.png', primary4, 'Bantuan'),
            navDest('assets/images/icons/profile.png', primary4, 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget navDest(img, color, label) {
    return NavigationDestination(
      selectedIcon: Image.asset(
        img,
        color: color,
        width: 20,
      ),
      icon: Image.asset(
        img,
        width: 20,
      ),
      label: label,
    );
  }
}

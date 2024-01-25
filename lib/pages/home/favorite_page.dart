// delia

import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteMenu extends StatefulWidget {
  const FavoriteMenu({super.key});

  @override
  State<FavoriteMenu> createState() => _FavoriteMenuState();
}

class _FavoriteMenuState extends State<FavoriteMenu> {
  int addToBasket = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      body: favoritePage(),
    );
  }

  showAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/images/icons/backButton.png'),
          ),
          const SizedBox(width: 8),
          Text(
            "Menu Favorit",
            style: poppins.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18), 
          ),
        ],
      ),
    );
  }

  Widget favoritePage() {
    return Consumer<FavoritesMenuProvider>(
        builder: (context, favProvider, child) {
      if (favProvider.favMenu.isNotEmpty) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: favProvider.favMenu.length,
                itemBuilder: ((BuildContext context, index) {
                  return favMenuMaker(context, favProvider.favMenu[index]);
                }),
              ),
            ),
          ],
        );
      } else {
        return noDataPopUp(context, 'Belum ada menu favorit',
            MediaQuery.of(context).size.height);
      }
    });
  }
}

//  ali

import 'package:capstone_restaurant/data.dart';
import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/home/favorite_page.dart';
import 'package:capstone_restaurant/pages/home/popup_menu_page.dart';
import 'package:capstone_restaurant/pages/home/search_page.dart';
import 'package:capstone_restaurant/pages/order/cart_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MenubyCat extends StatefulWidget {
  final String selectedCat;
  const MenubyCat({super.key, required this.selectedCat});

  @override
  State<MenubyCat> createState() => _MenubyCatState();
}

class _MenubyCatState extends State<MenubyCat> {
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: showAppBar(),
      body: menubyCatPage(),
    );
  }

  showAppBar() {
    return AppBar(
      scrolledUnderElevation: 1,
      backgroundColor: Colors.transparent,
      surfaceTintColor: primary4,
      shadowColor: primary4,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/images/icons/backButtonW.png'),
          ),
          SizedBox(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const CartPage(),
                            type: PageTransitionType.fade));
                    debugPrint('cart tertekan');
                  },
                  child: Image.asset('assets/images/icons/cartW.png'),
                ),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const FavoriteMenu(),
                            type: PageTransitionType.fade));
                    debugPrint('favorit tertekan');
                  },
                  child: Image.asset('assets/images/icons/favW.png'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget menubyCatPage() {
    final menuProvider = Provider.of<MenuDataProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Stack(
        children: [
          // bg image
          Container(
            width: MediaQuery.of(context).size.width,
            height: 319,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/home/homePage/menubyCat/background.png'),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter)),
          ),
          // search bar ---------------
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const SearchPage(),
                        type: PageTransitionType.fade));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 300),
                decoration: homePageMenuBuilder,
                width: MediaQuery.of(context).size.width - 82,
                height: 44,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/icons/search.png',
                        width: 15,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Cari makananmu disini',
                        style: poppins.copyWith(fontSize: 11, color: outline),
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/images/icons/filter.png',
                        width: 17,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // category
          Container(
            margin: const EdgeInsets.only(top: 320),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21, top: 46, right: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kategori',
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                      SizedBox(
                        height: 78,
                        child: ListView.builder(
                          itemCount: catData.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String title = catData[index][0];
                            String img = catData[index][1];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = title;
                                });
                                debugPrint('$title tertekan');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 194,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: primary2,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                        offset: Offset(0, 0),
                                        spreadRadius: -2,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          img,
                                          width: 62,
                                        ),
                                        Text(
                                          title,
                                          style: poppins.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21, top: 17, right: 35),
                  child: Column(
                    children: [
                      Text(selectedCategory,
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 20)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 520),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                // itemCount: 1,
                itemCount:
                    menuProvider.getMenuByCat(selectedCategory).length ?? 0,
                itemBuilder: (context, index) {
                  return showMenuByCat(context,
                      menuProvider.getMenuByCat(selectedCategory)[index]);
                },
              ))
        ],
      ),
    );
  }
}

Widget showMenuByCat(context, data) {
  final cartHandler = Provider.of<CartHandler>(context, listen: false);

  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          PageTransition(
              child: PopUpMenuDetail(
                data: data,
              ),
              type: PageTransitionType.fade));
      debugPrint('menu ${data['name']} tertekan');
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 41, left: 21, right: 35),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(data['img'], fit: BoxFit.cover)),
          ),
          const SizedBox(width: 18),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 135,
                    child: Text(
                      data['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: poppins.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Consumer<FavoritesMenuProvider>(
                      builder: (context, favProvider, child) {
                    return GestureDetector(
                      onTap: () {
                        favProvider.addToFav(data);
                      },
                      child: Image.asset(
                        'assets/images/icons/favW.png',
                        color: favProvider.favMenu.contains(data)
                            ? primary3
                            : bright,
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 48,
                width: 135,
                child: Text(
                  data['desc'],
                  style: poppins.copyWith(fontSize: 14, color: outline),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Row(
                children: [
                  Text(
                    data['price'],
                    style: poppins.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: primary4),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      cartHandler.addToCart(data['name'], 1, data['price']);
                      showSnackBar(context, '${data['name']} added to cart.');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary4,
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Center(
                          child: Text(
                            '+ Add',
                            style: poppins.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: primary2),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    ),
  );
}

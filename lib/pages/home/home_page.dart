// Rachel

import 'package:capstone_restaurant/data.dart';
import 'package:capstone_restaurant/logic/data_api_handler.dart';
import 'package:capstone_restaurant/pages/home/favorite_page.dart';
import 'package:capstone_restaurant/pages/home/menu_by_cat_page.dart';
import 'package:capstone_restaurant/pages/home/notification_page.dart';
import 'package:capstone_restaurant/pages/home/popup_menu_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Function changePageIndex;
  const HomePage({super.key, required this.changePageIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(toolbarHeight: 5),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  showGreeting(widget.changePageIndex),
                  showBanner(),
                  showCat(),
                  showRecommendation(),
                  showFavMenu(),
                  showPromo(),
                  showBestSeller()
                ],
              ),
            ));
  }

  Widget showGreeting(Function changePageIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 21, right: 21, bottom: 21),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              debugPrint('tertekan');
              changePageIndex(3);
            },
            child: const CircleAvatar(
                radius: 23,
                backgroundImage:
                    AssetImage('assets/images/home/accPage/avatar.png')),
          ),
          const SizedBox(width: 11),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ${localUserData[0]}!',
                // 'Hello !',
                style: poppins.copyWith(fontSize: 15),
              ),
              Text(
                'Mau makan apa hari ini?',
                style:
                    poppins.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const NotificationPage(),
                      type: PageTransitionType.fade));
              debugPrint('notification tertekan');
            },
            child: Image.asset('assets/images/icons/notification.png'),
          )
        ],
      ),
    );
  }

  Widget showBanner() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: SizedBox(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width - 8,
          child: Stack(
            children: [
              Center(
                child: CarouselSlider(
                    items: [
                      ...bannerImg.map((data) => SizedBox(
                            width: double.infinity,
                            child: Image.asset(
                              data,
                              fit: BoxFit.fill,
                            ),
                          ))
                    ],
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      enlargeFactor: 0.2,
                      height: 237,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayCurve: Curves.easeOutQuint,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentCarouselIndex = index;
                        });
                      },
                    )),
              ),
              Positioned(
                  right: 26,
                  bottom: 34,
                  child: DotsIndicator(
                    dotsCount: bannerImg.length,
                    position: currentCarouselIndex,
                    decorator: DotsDecorator(
                        color: outline,
                        size: const Size(6, 6),
                        activeColor: primary2,
                        activeSize: const Size(26, 5),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                  )),
              // Positioned(
              //     left: 32,
              //     bottom: 42,
              //     child: Text(
              //       'Sajian Terbaik buat kamu kami \npersiapkan',
              //       style: poppins.copyWith(
              //           fontWeight: FontWeight.w700,
              //           fontSize: 16,
              //           color: primary2),
              //     )),
            ],
          )),
    );
  }

  Widget showCat() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'kategori',
                      style: poppins.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    )),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: catData.length, // Set the number of items
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (105 / 109),
                        crossAxisCount: 3,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: MenubyCat(
                                        selectedCat: catData[index][0]),
                                    type: PageTransitionType.fade));
                            debugPrint('${catData[index][0]} tertekan');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: primary2,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 6)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    catData[index][1],
                                    width: 74,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    catData[index][0],
                                    style: poppins.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showRecommendation() {
    final menuProvider = Provider.of<MenuDataProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 41),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rekomendasi Buat Kamu',
                  style: poppins.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 18),
                )),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/home/homePage/recommendation/banner.png',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width - 21,
            height: 380,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 25),
                shrinkWrap: true,
                itemCount: menuProvider.getMenu.length,
                itemBuilder: (BuildContext context, index) {
                  return recommendationMenuMaker(menuProvider.getMenu[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget showFavMenu() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 21, bottom: 12),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menu Favoritmu',
                style:
                    poppins.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
              )),
        ),
        Consumer<FavoritesMenuHandler>(builder: (context, favProvider, child) {
          if (favProvider.data.isNotEmpty) {
            return SizedBox(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: favProvider.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return favMenuMaker(context, favProvider.data[index]);
                  }),
            );
          } else {
            return SizedBox(
              height: 265,
              child: Center(
                child: Text(
                  'Belum ada menu favorit',
                  style: poppins.copyWith(fontSize: 17),
                ),
              ),
            );
          }
        }),
        Padding(
          padding: const EdgeInsets.only(right: 21),
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const FavoriteMenu(),
                        type: PageTransitionType.fade));
                debugPrint('Lihat lainnya tertekan');
              },
              child: Text(
                'Lihat lainnya',
                style: poppins.copyWith(
                    fontWeight: FontWeight.w400, fontSize: 13, color: outline),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget showPromo() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ada promo menarik nih',
                  style: poppins.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 18),
                )),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width - 14,
            child: Image.asset('assets/images/home/homePage/promoBanner.png'),
          )
        ],
      ),
    );
  }

  Widget showBestSeller() {
    final menuProvider = Provider.of<MenuDataProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Yuk, Cek menu terlaris kita',
                  style: poppins.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 18),
                )),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width - 21,
            height: 281,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 12),
                shrinkWrap: true,
                itemCount: menuProvider.getMenu.length,
                itemBuilder: (BuildContext context, index) {
                  return bestSellerMenuMaker(menuProvider.getMenu[index]);
                }),
          ),
        ],
      ),
    );
  }

  // ------------ Widget Builder ---------------------------

  Widget recommendationMenuMaker(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: PopUpMenuDetail(data: data),
                type: PageTransitionType.fade));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 200,
          ),
          child: Container(
            width: 230,
            decoration: homePageMenuBuilder,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                SizedBox(
                    width: 209,
                    height: 149,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          data['image'],
                          fit: BoxFit.cover,
                        ))),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<FavoritesMenuHandler>(
                        builder: (context, favProvider, child) {
                      return GestureDetector(
                        onTap: () {
                          favProvider.addToFav(data['id']);
                        },
                        child: Image.asset(
                          'assets/images/icons/favW.png',
                          color: favProvider.data.contains(data['id'])
                              ? primary3
                              : bright,
                        ),
                      );
                    })
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['name'],
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      Text('Rp ${data['price'].toString()}',
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: secondary3)),
                      Text(data['description'],
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: outline)),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        width: 37,
                        height: 18,
                        decoration: BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/icons/star.png',
                                width: 9,
                                color: Colors.white,
                              ),
                              Text('4.5',
                                  style: poppins.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: primary2)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('30 Min',
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: outline)),
                      const SizedBox(width: 8),
                      Text('• Best Menu',
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: outline)),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget bestSellerMenuMaker(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: PopUpMenuDetail(data: data),
                type: PageTransitionType.fade));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
        child: Container(
          width: 175,
          decoration: homePageMenuBuilder,
          child: Column(children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                data['image'],
                width: 175,
                height: 162,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          data['name'],
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 37,
                        height: 18,
                        decoration: BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icons/star.png',
                              width: 9,
                              color: Colors.white,
                            ),
                            Text('4.8',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: primary2)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data['description'],
                    style: poppins.copyWith(fontSize: 10, color: outline),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


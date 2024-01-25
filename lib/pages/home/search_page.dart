import 'package:capstone_restaurant/data.dart';
import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/home/menu_by_cat_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController foodSearchController = TextEditingController();
  bool showFilter = false;
  bool showSearchedFood = false;
  List filterData = ['', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      body: showFilter ? showFilterPage() : showSearchPage(),
    );
  }

  showAppBar() {
    return AppBar(
      toolbarHeight: 0,
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  Widget showSearchPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 33),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (showSearchedFood) {
                    setState(() {
                      showSearchedFood = !showSearchedFood;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Image.asset('assets/images/icons/backButton.png'),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: primary2,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: foodSearchController,
                    onSubmitted: (value) {
                      setState(() {
                        showSearchedFood = true;
                        if (value.isNotEmpty &&
                            !searchHistory.contains(value)) {
                          searchHistory.add(value);
                        }
                      });
                    },
                    style: poppins.copyWith(fontSize: 13, color: Colors.black),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          'assets/images/icons/search.png',
                          width: 12,
                        ),
                        hintText: 'Cari makananmu disini',
                        suffixIcon: showSearchedFood
                            ? IconButton(
                                onPressed: () {
                                  foodSearchController.clear;
                                  setState(() {
                                    showSearchedFood = !showSearchedFood;
                                    foodSearchController.clear();
                                  });
                                },
                                icon: const Icon(Icons.clear_rounded))
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showFilter = true;
                                  });
                                  debugPrint('filter tertekan');
                                },
                                child: Image.asset(
                                  'assets/images/icons/filter.png',
                                  scale: 3,
                                ),
                              )),
                  ),
                ),
              ),
            ],
          ),
        ),
        showSearchedFood ? section2() : section1()
      ],
    );
  }

  Widget section1() {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 18, top: 27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pencarian Terbaru',
                  style: poppins.copyWith(color: surface),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      searchHistory.clear();
                    });
                    debugPrint('hapus semua tertekan');
                  },
                  child: Text(
                    'Hapus Semua',
                    style: poppins.copyWith(color: surface),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: searchHistory.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  var data = searchHistory[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        showSearchedFood = true;
                      });

                      setState(() {
                        foodSearchController.text = data;
                      });
                      debugPrint('$data tertekan');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/icons/search.png',
                            width: 19,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            data,
                            style:
                                poppins.copyWith(fontSize: 16, color: outline),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }

  Widget section2() {
    final menuProvider = Provider.of<MenuDataProvider>(context, listen: false);
    List result = menuProvider.searchFood(foodSearchController.text);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 27),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: result.length,
          itemBuilder: (context, index) {
            if (result.isEmpty) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/home/homePage/kosong.png',
                        width: 110,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Waah, menu gak ketemu',
                              style: poppins.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Text(
                            'Sepertinya menu yang kamu\ncari gak ada, coba cari yang\nlain yuk!',
                            style: poppins,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: const Divider())
                ],
              );
            } else {
              return showMenuByCat(context, result[index]);
            }
          },
        ),
      ),
    );
  }

  Widget showFilterPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 44),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showFilter = !showFilter;
                  });
                },
                child: Image.asset('assets/images/icons/backButton.png'),
              ),
              const SizedBox(width: 8),
              Text(
                'Filter',
                style:
                    poppins.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 38, right: 18, top: 27),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Kategori',
              style: poppins.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                filterBubble('Semua'),
                const SizedBox(width: 8),
                filterBubble('Ala Carte'),
                const SizedBox(width: 8),
                filterBubble('Paket Hemat'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                filterBubble('Appetizer'),
                const SizedBox(width: 8),
                filterBubble('Minum'),
                const SizedBox(width: 8),
                filterBubble('Dessert'),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Rentang Harga',
              style: poppins.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                filterBubble('Rp 10.000-Rp 20.000'),
                const SizedBox(width: 8),
                filterBubble('Rp 20.000-Rp 40.000'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                filterBubble('Rp 40.000-Rp 60.000'),
                const SizedBox(width: 8),
                filterBubble('> Rp 60.000'),
              ],
            ),
          ]),
        )
      ],
    );
  }

  Widget filterBubble(text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (text.contains('Rp')) {
            filterData[1] = text;
          } else {
            filterData[0] = text;
          }
        });
        debugPrint(filterData.toString());
      },
      child: Container(
        height: 44,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: filterData.contains(text) ? primary4 : moreBright,
            borderRadius: BorderRadius.circular(49)),
        child: Center(
          child: Text(
            text,
            style: poppins.copyWith(
                color: filterData.contains(text) ? Colors.white : outline),
          ),
        ),
      ),
    );
  }
}

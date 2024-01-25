import 'package:capstone_restaurant/data.dart';
import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/home/popup_menu_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

summonDialog(context, {customTitle, customSubtitle}) {
  return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text(customTitle ?? 'Login Gagal',
                style: poppins.copyWith(fontSize: 20)),
            content: SizedBox(
              width: 220,
              height: 37,
              child: Text(
                  customSubtitle ??
                      'Silahkan cek kembali email dan Password anda.',
                  style: poppins.copyWith(fontSize: 14)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: poppins.copyWith(fontSize: 14),
                ),
              )
            ],
          )));
}

Widget fieldMaker(context, title, hint, controller,
    {prefilled, active, focusNode, reqFocus, textInputAction, inputType}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 17),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: poppins.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 2),
        TextField(
          keyboardType: inputType,
          focusNode: focusNode,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(reqFocus);
          },
          textInputAction: textInputAction,
          enabled: active,
          controller: controller,
          onTap: () {
            if (prefilled != null) {
              controller.text = prefilled;
            }
          },
          decoration: InputDecoration(
              hintText: hint, hintStyle: poppins.copyWith(color: outline)),
        )
      ],
    ),
  );
}

String formatDate(data) {
  DateTime dateTime = DateTime.parse(data);
  String formattedDate = DateFormat.yMMMMd().format(dateTime);
  return formattedDate;
}

Future<void> fetchDataFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  localUserData = prefs.getStringList('userData') ?? [];
}

addToMenuFav(id) {}

String formatCurrency(price) {
  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return currencyFormatter.format(price);
}

Widget favMenuMaker(context, data) {
  final cartHandler = Provider.of<CartHandler>(context, listen: false);
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          PageTransition(
              child: PopUpMenuDetail(data: data),
              type: PageTransitionType.fade));
    },
    child: Container(
        margin: const EdgeInsets.only(bottom: 13, left: 16, right: 16),
        decoration: BoxDecoration(
            color: primary2,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)]),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 120,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      data['img'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    left: 15,
                    bottom: 9,
                    child: Text(
                      '15 Min',
                      style: poppins.copyWith(fontSize: 16, color: primary2),
                    )),
                Positioned(
                  right: 25,
                  bottom: 13,
                  child: Consumer<FavoritesMenuProvider>(
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
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 160),
                              child: Text(data['name'],
                                  overflow: TextOverflow.ellipsis,
                                  style: poppins.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 37,
                              height: 18,
                              decoration: BoxDecoration(
                                  color: yellow,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(data['price'],
                            style: poppins.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 16))
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 48,
                      width: MediaQuery.of(context).size.width - 32,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['desc'],
                            style: poppins.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: outline),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartHandler.addToCart(
                                data['name'], 1, data['price']);
                            showSnackBar(
                                context, '${data['name']} added to cart.');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: primary4,
                              borderRadius: BorderRadius.circular(37),
                            ),
                            width: 86,
                            height: 32,
                            child: Center(
                              child: Text(
                                '+ Add',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: primary2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
  );
}

void showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1300),
      content: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              child: Text(
                msg,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: primary4,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );
}

Widget noDataPopUp(context, text, double height) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: height,
    child: Center(
      child: Text(
        text,
        style: poppins.copyWith(fontSize: 17),
      ),
    ),
  );
}

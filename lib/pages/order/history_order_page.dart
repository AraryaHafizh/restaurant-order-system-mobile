import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/order/input_rating_page.dart';
import 'package:capstone_restaurant/pages/order/order_page.dart';
import 'package:capstone_restaurant/pages/order/receipt_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget historyOrder(context, index, items) {
  final menuProvider = Provider.of<MenuDataProvider>(context, listen: false);
  final orderProvider = Provider.of<OrderProvider>(context, listen: false);
  var price = orderProvider.price[index];
  var qty = orderProvider.quantity[index];
  Map foodData = menuProvider.getMenuDetails(items[0]['name']);
  // return Text(foodData.toString());
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  child: ReceiptPage(
                    data: items,
                    orderIdx: index,
                    totalPrice: price,
                  ),
                  type: PageTransitionType.fade));
        },
        child: Container(
            width: MediaQuery.of(context).size.width - 32,
            margin: const EdgeInsets.only(bottom: 13),
            decoration: BoxDecoration(
                color: primary2,
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6)
                ]),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 32,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(22)),
                            child: Image.network(foodData['img'],
                                fit: BoxFit.cover))),
                    Positioned(
                        left: 15,
                        bottom: 9,
                        child: Text(
                          '30 Min',
                          style:
                              poppins.copyWith(fontSize: 16, color: primary2),
                        )),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 165,
                                child: Text(foodData['name'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: poppins.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          Text(formatCurrency(price),
                              style: poppins.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('$qty item | 4 km',
                                  style: poppins.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: outline)),
                              const SizedBox(width: 10),
                            ],
                          ),
                          Text('Dikirim ke alamat',
                              style: poppins.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: outline))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          orderButtonMaker(context, 'kasih Rating', primary2,
                              color: primary4,
                              route: InputRating(
                                data: items,
                                qty: qty,
                                img: foodData['img'],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    ],
  );
}

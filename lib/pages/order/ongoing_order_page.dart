import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/order/order_page.dart';
import 'package:capstone_restaurant/pages/order/order_status.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget ongoingOrder(context, index, items) {
  final menuProvider = Provider.of<MenuDataProvider>(context, listen: false);
  final orderProvider = Provider.of<OrderProvider>(context, listen: false);
  var price = orderProvider.price[index];
  var qty = orderProvider.quantity[index];
  Map foodData = menuProvider.getMenuDetails(items[0]['name']);
  return Container(
      margin: const EdgeInsets.only(bottom: 13, left: 16, right: 16),
      decoration: BoxDecoration(
          color: primary2,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2)
          ]),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width - 32,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    foodData['img'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  left: 15,
                  bottom: 9,
                  child: Text(
                    '30 Min',
                    style: poppins.copyWith(fontSize: 16, color: primary2),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                  fontWeight: FontWeight.w500, fontSize: 16)),
                        ),
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
                    orderButtonMaker(context, 'Lacak status pesanan', primary2,
                        color: primary4,
                        route: OrderStatus(
                          clearCart: false,
                          orderData: items,
                          totalPrice: price,
                          orderIdx: index,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ));
}

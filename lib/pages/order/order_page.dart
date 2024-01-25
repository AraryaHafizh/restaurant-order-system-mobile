import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/order/history_order_page.dart';
import 'package:capstone_restaurant/pages/order/ongoing_order_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isBerlangsungSelected = true;
  bool isRiwayatSelected = false;
  bool isDibatalkanSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orderPage(),
    );
  }

  showAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Text(
            "Pesanan",
            style: poppins.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ],
      ),
      bottom: TabBar(
          splashFactory: NoSplash.splashFactory,
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return states.contains(MaterialState.focused)
                ? null
                : Colors.transparent;
          }),
          indicatorColor: primary4,
          labelColor: primary4,
          labelStyle:
              poppins.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          tabs: const [
            Tab(
              text: 'Berlangsung',
            ),
            Tab(
              text: 'Riwayat',
            ),
          ]),
    );
  }

  Widget orderPage() {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: showAppBar(),
          body: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: TabBarView(children: [
              Consumer<OrderProvider>(builder: (context, orderProvider, child) {
                if (orderProvider.ongoing.isNotEmpty) {
                  return SizedBox(
                      child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: orderProvider.ongoing.length,
                    itemBuilder: ((BuildContext context, index) {
                      return ongoingOrder(
                        context,
                        index,
                        orderProvider.ongoing[index],
                      );
                    }),
                  ));
                } else {
                  return noDataPopUp(context, 'Belum ada pesanan',
                      MediaQuery.of(context).size.height);
                }
              }),
              Consumer<OrderProvider>(builder: (context, orderProvider, child) {
                if (orderProvider.history.isNotEmpty) {
                  return SizedBox(
                      child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: orderProvider.history.length,
                    itemBuilder: ((BuildContext context, index) {
                      return historyOrder(
                        context,
                        index,
                        orderProvider.history[index],
                      );
                    }),
                  ));
                } else {
                  return noDataPopUp(context, 'Belum ada riwayat pesanan',
                      MediaQuery.of(context).size.height);
                }
              }),
            ]),
          ),
        ));
  }
}

Widget orderButtonMaker(context, title, titleColor, {color, route}) {
  return GestureDetector(
    onTap: () {
      if (route != null && title != 'Dibatalkan') {
        Navigator.push(context,
            PageTransition(child: route, type: PageTransitionType.fade));
      }
      debugPrint('$title tertekan');
    },
    child: Container(
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(37),
        border: color == null
            ? Border.all(color: primary4, strokeAlign: 1)
            : Border.all(color: Colors.transparent, strokeAlign: 0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Center(
          child: Text(
            title,
            style: poppins.copyWith(
                fontWeight: FontWeight.w500, fontSize: 13, color: titleColor),
          ),
        ),
      ),
    ),
  );
}

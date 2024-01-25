import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/help/help_page.dart';
import 'package:capstone_restaurant/pages/home/home.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatefulWidget {
  final bool clearCart;
  final dynamic orderData;
  final dynamic totalPrice;
  final dynamic orderIdx;

  const OrderStatus(
      {super.key,
      required this.clearCart,
      this.orderData,
      this.totalPrice,
      this.orderIdx});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  void initState() {
    super.initState();
    orderStatusDemo();
  }

  Future<void> orderStatusDemo() async {
    final orderStatusDemoProvider =
        Provider.of<OrderStatusDemoProvider>(context, listen: false);
    orderStatusDemoProvider.resetOrderStatus();

    await orderStatusDemoProvider.orderStatusDemo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: moreBright,
        appBar: showAppBar(),
        body: orderStatusPage());
  }

  showAppBar() {
    final cartProvider = Provider.of<CartHandler>(context, listen: false);
    return AppBar(
      backgroundColor: moreBright,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              widget.clearCart ? cartProvider.clearCart() : null;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Home(setIdx: 1)),
                  (route) => false);
            },
            child: Image.asset('assets/images/icons/backButton.png'),
          ),
          const SizedBox(width: 8),
          Text(
            "Status Pesanan Saya",
            style: poppins.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18), 
          ),
        ],
      ),
    );
  }

  Widget orderStatusPage() {
    return Stack(
      children: [
        section1(),
        section2(),
      ],
    );
  }

  Widget section1() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 37, right: 37, bottom: 37),
          child: Column(
            children: [
              Image.asset('assets/images/order/confirm3.png'),
              Text(
                'Estimasi waktu pengiriman : 30 menit',
                style: poppins.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 50, top: 15, right: 30),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(0, -5),
                )
              ],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(56),
              ),
            ),
            child: Consumer<OrderStatusDemoProvider>(
                builder: (context, orderStatusDemoProvider, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: orderStatusDemoProvider.data.length,
                padding: const EdgeInsets.only(bottom: 100),
                itemBuilder: (BuildContext context, index) {
                  return statusIndicator(orderStatusDemoProvider.data[index]);
                },
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget section2() {
    final cartProvider = Provider.of<CartHandler>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return SizedBox(
        child: DraggableScrollableSheet(
      minChildSize: 0.1,
      maxChildSize: 0.9,
      initialChildSize: 0.1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(0, -5),
              )
            ],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(56),
            ),
          ),
          child: Stack(children: [
            widget.clearCart
                ? Container(
                    margin: const EdgeInsets.only(top: 145),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: cartProvider.cart.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: ((BuildContext context, index) {
                                return listOrderMaker(
                                  index,
                                  cartProvider.cart[index],
                                  widget.clearCart,
                                );
                              }),
                            ),
                            calculatePrice(
                                'Subtotal', formatCurrency(cartProvider.price)),
                            calculatePrice('Ongkir', '12.500'),
                            calculatePrice('Biaya lain-lain', '2.000'),
                            calculatePrice('Voucher Promo', '0'),
                            calculatePrice('Diskon Ongkir', '0'),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(),
                            ),
                            calculatePrice('Total Pembayaran',
                                formatCurrency(cartProvider.price + 14500)),
                            const SizedBox(height: 25),
                            finishButton(context, widget.orderIdx, false),
                            const SizedBox(height: 25),
                          ],
                        )))
                : Container(
                    margin: const EdgeInsets.only(top: 145),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: widget.orderData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: ((BuildContext context, index) {
                                return listOrderMaker(index,
                                    widget.orderData[index], widget.clearCart,
                                    notes:
                                        orderProvider.notes[widget.orderIdx]);
                              }),
                            ),
                            calculatePrice('Subtotal',
                                formatCurrency(widget.totalPrice - 14500)),
                            calculatePrice('Ongkir', '12.500'),
                            calculatePrice('Biaya lain-lain', '2.000'),
                            calculatePrice('Voucher Promo', '0'),
                            calculatePrice('Diskon Ongkir', '0'),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(),
                            ),
                            calculatePrice('Total Pembayaran',
                                formatCurrency(widget.totalPrice)),
                            const SizedBox(height: 25),
                            finishButton(context, widget.orderIdx, true),
                            const SizedBox(height: 25),
                          ],
                        ))),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 29, right: 30),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 11),
                      child: Align(
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/login/handle.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Daftar Pesanan',
                            style: poppins.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: const HelpPage(route: false),
                                      type: PageTransitionType.fade));
                            },
                            child: CircleAvatar(
                              backgroundColor: primary4,
                              child: Image.asset(
                                'assets/images/icons/pesanan.png',
                                width: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Pesanan mu',
                      style: poppins.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    ));
  }

  // ----------------------------------------------------------------

  Widget statusIndicator(data) {
    var isFirst = data[0];
    var isLast = data[1];
    var isPast = data[2];
    var title = data[3];
    var subtitle = data[4];
    var img = data[5];
    return SizedBox(
      height: 85,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(color: isPast ? primary1 : surface),
        indicatorStyle: IndicatorStyle(color: isPast ? primary1 : surface),
        endChild: eventCard(title, subtitle, img, isPast),
      ),
    );
  }

  Widget eventCard(title, subtitle, img, isPast) {
    return Container(
      margin: const EdgeInsets.only(left: 19, top: 23),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: isPast ? primary4 : surface,
            child: Image.asset(
              img,
              width: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: poppins.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: isPast ? Colors.black : outline),
                ),
                Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: poppins.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: isPast ? outline : surface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------

  Widget listOrderMaker(index, data, clearCart, {notes}) {
    final cartProvider = Provider.of<CartHandler>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 29, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${data['name']}  x${data['quantity']}',
                    style: poppins.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    formatCurrency(data['originalPrice']),
                    style: poppins.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: primary4),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 217,
                height: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Catatan: ',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: outline)),
                            TextSpan(
                                text: clearCart
                                    ? cartProvider.notes[index]
                                    : notes[index],
                                style: poppins.copyWith(color: outline)),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 13, right: 13, bottom: 16),
          child: Divider(),
        )
      ],
    );
  }

  Widget calculatePrice(title, String price) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    poppins.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                price,
                style:
                    poppins.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget finishButton(context, index, isActive) {
  final orderProvider = Provider.of<OrderProvider>(context, listen: false);
  return Consumer<OrderStatusDemoProvider>(
      builder: (context, orderStatusDemoProvider, child) {
    return GestureDetector(
      onTap: () {
        if (isActive && orderStatusDemoProvider.status) {
          orderProvider.orderFinished(index);
          Navigator.pop(context);
        } else {
          debugPrint('not allowed');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 50,
        decoration: BoxDecoration(
          color: orderStatusDemoProvider.status && isActive ? primary4 : bright,
          borderRadius: BorderRadius.circular(37),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Center(
            child: Text(
              'Finish Order',
              style: poppins.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  });
}

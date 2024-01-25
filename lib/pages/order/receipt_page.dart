import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptPage extends StatefulWidget {
  final List data;
  final dynamic orderIdx;
  final dynamic totalPrice;
  const ReceiptPage({super.key, required this.data, this.orderIdx, this.totalPrice});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      body: showReceipt(),
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
            "History Pesanan",
            style: poppins.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget showReceipt() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 19),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dikirim ke alamat',
                    style: poppins.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    '14 Desember 2023',
                    style: poppins.copyWith(fontSize: 14, color: outline),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/icons/home2.png',
                        color: outline,
                        width: 19,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'My home',
                        style: poppins.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: outline),
                      )
                    ],
                  ),
                  Text(
                    'Pesanan ke-${widget.orderIdx + 1}',
                    style: poppins.copyWith(fontSize: 14, color: outline),
                  )
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 35),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Pesanan mu',
              style:
                  poppins.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: ListView.builder(
                    itemCount: widget.data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return showMyOrder(index, widget.data[index],
                          orderProvider.notes[widget.orderIdx]);
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 29, right: 44, bottom: 11, top: 19),
                    child: Column(
                      children: [
                        Wrap(
                          runSpacing: 3,
                          children: [
                            showPrice('Subtotal',
                                formatCurrency(widget.totalPrice - 14500)),
                            showPrice('Ongkir', '12.500'),
                            showPrice('Biaya lain-lain', '2.000'),
                            showPrice('Voucher Promo', '0'),
                            showPrice('Diskon Ongkir', '0'),
                          ],
                        ),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 29, right: 29),
                  child: Divider(),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 29, right: 44, bottom: 76),
                    child: Column(
                      children: [
                        Wrap(
                          runSpacing: 3,
                          children: [
                            showPrice('Total Pembayaran',
                                formatCurrency(widget.totalPrice))
                          ],
                        ),
                      ],
                    )),
                const SizedBox(height: 73)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showMyOrder(index, data, notes) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        data['name'],
                        style: poppins.copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      formatCurrency(data['price']),
                      style: poppins.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 205,
                  child: RichText(
                      maxLines: 2,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'catatan: ',
                          style: poppins.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: outline),
                        ),
                        TextSpan(
                          text: notes[index],
                          style: poppins.copyWith(color: outline),
                        ),
                      ])),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 29, right: 29, top: 9),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget showPrice(title, price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: poppins.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          price,
          style: poppins.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }
}

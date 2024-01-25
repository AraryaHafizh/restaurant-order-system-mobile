import 'package:capstone_restaurant/pages/order/confirmation_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      body: paymentPage(),
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
            "Pembayaran",
            style: poppins.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget paymentPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: homePageMenuBuilder.copyWith(
                  borderRadius: BorderRadius.circular(28), color: moreBright),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 19, top: 24),
                    child: Text(
                      'Pesanan mu',
                      style: poppins.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((BuildContext context, index) {
                      return listOrderMaker();
                    }),
                  )),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 11, top: 14),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                'Rp xxxxx',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ongkir',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                '   xxxxx',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Biaya lain-lain',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                '   xxxxx',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 13),
                            child: Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 39, top: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Pembayaran',
                                  style: poppins.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Text(
                                  'Rp xxxxx',
                                  style: poppins.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: primary4),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pembayaran',
                  style: poppins.copyWith(fontSize: 15),
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      '2 Min 45 Sec',
                      style: poppins.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: primary4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Due date: Today',
                      style: poppins.copyWith(
                          fontSize: 11, fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            height: 24,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: moreBright),
          ),
          GestureDetector(
            onTap: () {
              confirmDialog(context);
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const ConfirmationPage(),
                        type: PageTransitionType.fade));
              });
              debugPrint('Pesan Sekarang tertekan');
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: primary4,
                borderRadius: BorderRadius.circular(37),
              ),
              width: 335,
              height: 48,
              child: Center(
                child: Text(
                  'Konfirmasi',
                  style: poppins.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listOrderMaker() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Kentang Goreng',
                    style: poppins.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    'Rp 34.000',
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
                                text:
                                    'iaosjmjgilaslig iogna niaowngoin12 1ion 1n  fawfa gsad asfa agf s',
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
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Divider(),
        )
      ],
    );
  }

  void confirmDialog(context) {
    bool manuallyclosed = false;
    Future.delayed(const Duration(seconds: 2), () {
      if (!manuallyclosed) {
        Navigator.pop(context);
      }
    });

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              height: 210,
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/icons/checklist_green.png',
                      width: 94,
                    ),
                    const Spacer(),
                    Text(
                      'Payment Successful!',
                      style: poppins.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

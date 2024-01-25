import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/home/home.dart';
import 'package:capstone_restaurant/pages/order/order_status.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage>
    with TickerProviderStateMixin {
  TextEditingController cancelReason = TextEditingController();
  bool isLoading = true;
  bool showSeccondScreen = false;
  late AnimationController progressController;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), (() {
      setState(() {
        isLoading = false;
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tertiary2,
      appBar: showAppBar(),
      body: confirmPage(),
    );
  }

  showAppBar() {
    return AppBar(
      backgroundColor: tertiary2,
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
            "Konfirmasi",
            style: poppins.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget confirmPage() {
    return Column(
      children: [
        Image.asset(
          isLoading
              ? 'assets/images/order/confirm.png'
              : 'assets/images/order/confirm2.png',
        ),
        Visibility(
          visible: isLoading,
          child: Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 9),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(56))),
              child: Column(
                children: [
                  Image.asset('assets/images/login/handle.png'),
                  const SizedBox(height: 50),
                  Text(
                    'Sebentar ya, pesanan mu masih\ndalam konfirmasi',
                    textAlign: TextAlign.center,
                    style: poppins.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          color: primary4,
                          strokeWidth: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: !isLoading,
          child: Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 9),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(56))),
              child: Column(
                children: [
                  Image.asset('assets/images/login/handle.png'),
                  const SizedBox(height: 50),
                  Text(
                    'Pesananmu sudah di \nkonfirmasi yeay!\nYuk, lihat status pesananmu',
                    textAlign: TextAlign.center,
                    style: poppins.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 57),
                    child: GestureDetector(
                      onTap: () {
                        final cartHandler =
                            Provider.of<CartHandler>(context, listen: false);

                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                child: const Home(setIdx: 1),
                                //  OrderStatus(
                                //   clearCart: true,
                                // ),
                                type: PageTransitionType.fade),
                            (route) => false);
                        cartHandler.clearCart();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: primary4,
                          borderRadius: BorderRadius.circular(37),
                        ),
                        width: 335,
                        height: 48,
                        child: Center(
                          child: Text(
                            'Lihat Status Pesanan',
                            style: poppins.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future addCancelreason(context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: primary2,
        isScrollControlled: true,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(56)),
        ),
        builder: ((context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                // height: 403,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 29, top: 29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kenapa membatalkan pesanan?',
                            style: poppins.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 32, left: 20, right: 20),
                      child: TextField(
                        controller: cancelReason,
                        decoration: userInputNote.copyWith(
                          hintText: 'Salah pilih menu',
                          hintStyle: poppins.copyWith(color: Colors.black45),
                        ),
                        maxLines: 3,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 64, bottom: 79),
                        child: GestureDetector(
                          onTap: () {
                            debugPrint('Simapn tertekan');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: primary4,
                              borderRadius: BorderRadius.circular(37),
                            ),
                            width: 335,
                            height: 48,
                            child: Center(
                              child: Text(
                                'Simpan',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: primary2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        })).whenComplete(() {
      cancelReason.clear();
    });
  }
}

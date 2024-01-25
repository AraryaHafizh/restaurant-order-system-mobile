import 'package:capstone_restaurant/pages/home/menu_by_cat_page.dart';
import 'package:capstone_restaurant/pages/order/confirmation_page.dart';
import 'package:capstone_restaurant/pages/profile/address_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../logic/provider_handler.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool checkBoxVal = false;
  TextEditingController inputUserNote = TextEditingController();
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      body: confirmOrderPage(),
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
            "Konfirmasi Pesanan",
            style: poppins.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget confirmOrderPage() {
    final cartHandler = Provider.of<CartHandler>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Consumer<AddressProvider>(
                builder: (context, addressprovider, child) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 32, left: 16, right: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const AddressPage(isRebuild: true),
                            type: PageTransitionType.fade));

                    debugPrint('alamat tertekan');
                  },
                  child: Container(
                    decoration: homePageMenuBuilder.copyWith(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: addressprovider.data.isEmpty
                        ? SizedBox(
                            height: 120,
                            child: Center(
                              child: Text(
                                'Belum ada alamat tersimpan.',
                                style: poppins,
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 120,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, left: 15, right: 15, bottom: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/icons/home2.png',
                                      width: 17,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            addressprovider
                                                .data[addressprovider.idx][3],
                                            style:
                                                poppins.copyWith(fontSize: 15),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            addressprovider
                                                .data[addressprovider.idx][0],
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: poppins.copyWith(
                                                fontSize: 13, color: outline),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                  ),
                ),
              );
            }),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icons/timer.png',
                    width: 17,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Estimasi waktu pengiriman : 30 menit (4 km)',
                    style: poppins.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 16, right: 16),
              child: Container(
                decoration: homePageMenuBuilder.copyWith(
                  borderRadius: BorderRadius.circular(28),
                ),
                width: MediaQuery.of(context).size.width,
                child: Consumer<CartHandler>(
                    builder: (context, cartHandler, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 33, bottom: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pesanan mu',
                                  style: poppins.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            child: const MenubyCat(
                                                selectedCat: 'Appetizer'),
                                            type: PageTransitionType.fade));
                                  },
                                  child: Text(
                                    '+Tambah pesanan',
                                    style: poppins.copyWith(
                                        color: primary1, fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartHandler.cart.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((BuildContext context, index) {
                          return listOrderMaker(cartHandler.cart[index], index);
                        }),
                      )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 11, top: 14),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: poppins.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    formatCurrency(cartHandler.totalPrice),
                                    style: poppins.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ongkir',
                                    style: poppins.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '12.500',
                                    style: poppins.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Biaya lain-lain',
                                    style: poppins.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '2.000',
                                    style: poppins.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 39, top: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Pembayaran',
                              style: poppins.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(
                              formatCurrency(cartHandler.totalPrice + 14500),
                              style: poppins.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: primary4),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 23),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Optional',
                  style: poppins.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: outline),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: checkBoxVal,
                    checkColor: primary2,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return primary4;
                        }
                        return surface;
                      },
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    side: BorderSide.none,
                    onChanged: (bool? newValue) {
                      setState(() {
                        checkBoxVal = newValue!;
                      });
                    },
                  ),
                  Text(
                    'Self Pick Up / Ambil sendiri',
                    style: poppins.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: outline),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 31, horizontal: 31),
              child: GestureDetector(onTap: () {
                if (cartHandler.cart.isNotEmpty) {
                  // print(cartHandler.cart);
                  orderProvider.placeOrder(cartHandler.cart, cartHandler.notes,
                      cartHandler.price + 14500, cartHandler.quantity);
                  toNextPage();
                  print(cartHandler.notes);
                }
              }, child:
                  Consumer<CartHandler>(builder: (context, cartHandler, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: cartHandler.cart.isEmpty ? bright : primary4,
                    borderRadius: BorderRadius.circular(37),
                  ),
                  width: 335,
                  height: 48,
                  child: Center(
                    child: Text(
                      'Pesan Sekarang',
                      style: poppins.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                );
              })),
            )
          ],
        ),
      ),
    );
  }

  toNextPage() {
    Navigator.push(
      context,
      PageTransition(
        child: const ConfirmationPage(),
        type: PageTransitionType.fade,
      ),
    );
  }

  Widget listOrderMaker(data, index) {
    final cartProvider = Provider.of<CartHandler>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 18),
          child: Column(
            children: [
              Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 160),
                    child: Text(
                      data['name'],
                      style: poppins.copyWith(
                          fontWeight: FontWeight.w400, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      addNote(context, index);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icons/edit.png',
                          width: 8,
                          color: primary1,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Catatan',
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              color: primary1),
                        ),
                      ],
                    ),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                                    text: cartProvider.notes[index],
                                    style: poppins.copyWith(color: outline)),
                              ],
                            ))
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartProvider.decrementItem(
                                index, data['name'], data['originalPrice']);
                            debugPrint('decrement tertekan');
                          },
                          child: Image.asset(
                            'assets/images/icons/decrement.png',
                            width: 24,
                          ),
                        ),
                        Text(
                          data['quantity'].toString(),
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartProvider.incrementItem(
                                data['name'], data['originalPrice']);
                            debugPrint('increment tertekan');
                          },
                          child: Image.asset(
                            'assets/images/icons/increment.png',
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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

  Future addNote(context, index) {
    final cartProvider = Provider.of<CartHandler>(context, listen: false);

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
                height: 618,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 29, top: 29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Catatan Pesanan',
                            style: poppins.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tambah catatan pesananmu disini ya, agar kami tahu apa yang kamu perlukan',
                            style:
                                poppins.copyWith(fontSize: 14, color: surface),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 32, left: 20, right: 20),
                      child: TextFormField(
                        controller: inputUserNote,
                        style: poppins,
                        onTap: () {
                          inputUserNote.text = cartProvider.notes[index] ?? '';
                        },
                        decoration: userInputNote.copyWith(
                          hintText: 'Contoh: Banyakin porsinya bang, hehe',
                          hintStyle: poppins.copyWith(color: Colors.black45),
                        ),
                        maxLines: 6,
                        maxLength: 200,
                        buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$currentLength/$maxLength',
                              style: poppins.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: surface,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 111),
                        child: GestureDetector(
                          onTap: () {
                            cartProvider.addNote(index, inputUserNote.text);
                            Navigator.pop(context);
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
      inputUserNote.clear();
    });
  }
}

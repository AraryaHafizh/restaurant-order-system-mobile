import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/profile/add_address_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatefulWidget {
  final bool isRebuild;
  const AddressPage({super.key, required this.isRebuild});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar(),
      body: addressListPage(),
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
            "Atur alamat pengiriman",
            style: poppins.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18), 
          ),
        ],
      ),
    );
  }

  Widget addressListPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 19, top: 34),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Alamat',
                  style: poppins.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const AddAddress(
                              editMode: false,
                              isMainAddress: false,
                            ),
                            type: PageTransitionType.fade));
                  },
                  child: Text(
                    '+ Tambah Alamat',
                    style: poppins.copyWith(color: primary1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 23),
            Consumer<AddressProvider>(
                builder: (context, addressprovider, child) {
              return addressprovider.data.isEmpty
                  ? noDataPopUp(context, 'Belum ada alamat tersimpan.',
                      MediaQuery.of(context).size.height / 1.5)
                  : SizedBox(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: addressprovider.data.length,
                        itemBuilder: (context, index) {
                          return showAddressList(
                              index, addressprovider.data[index]);
                        },
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }

  Widget showAddressList(index, data) {
    final addressprovider =
        Provider.of<AddressProvider>(context, listen: false);
    String detailLokasi = data[0];
    String namaLengkap = data[1];
    String noHp = data[2];
    String tag = data[3];
    String patokan = data[4];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: AddAddress(
                  title: 'Edit Address',
                  detailLokasi: detailLokasi,
                  namaLengkap: namaLengkap,
                  noHp: noHp,
                  tag: tag,
                  patokan: patokan,
                  editMode: true,
                  isMainAddress: addressprovider.idx == index,
                  idx: index,
                ),
                type: PageTransitionType.fade));
        debugPrint('address $tag tertekan');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: homePageMenuBuilder.copyWith(
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/icons/home2.png',
                      width: 17,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tag,
                      style: poppins.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    threeDots(index),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '$namaLengkap - $noHp',
                      style: poppins.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  patokan,
                  style: poppins.copyWith(fontSize: 11),
                ),
                const SizedBox(height: 8),
                Text(
                  detailLokasi,
                  style: poppins.copyWith(fontSize: 13, color: outline),
                ),
              ],
            )),
      ),
    );
  }

  Widget threeDots(idx) {
    final addressprovider =
        Provider.of<AddressProvider>(context, listen: false);
    return PopupMenuButton(
      surfaceTintColor: Colors.white,
      iconSize: 20,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text(
            'Set default address',
            style: poppins.copyWith(fontSize: 13),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            'Delete address',
            style: poppins.copyWith(fontSize: 13),
          ),
        ),
      ],
      onSelected: (value) async {
        switch (value) {
          case 1:
            addressprovider.setDefaultAddress(idx);
            widget.isRebuild ? Navigator.pop(context) : null;
            showSnackBar(
                context, '${addressprovider.data[idx][3]} set as default.');
          case 2:
            showSnackBar(context, '${addressprovider.data[idx][3]} deleted.');
            addressprovider.deleteAddress(idx);
        }
      },
    );
  }
}

import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  final dynamic detailLokasi;
  final dynamic namaLengkap;
  final dynamic noHp;
  final dynamic tag;
  final dynamic patokan;
  final dynamic title;
  final dynamic editMode;
  final dynamic isMainAddress;
  final dynamic idx;
  const AddAddress(
      {super.key,
      this.detailLokasi,
      this.namaLengkap,
      this.noHp,
      this.tag,
      this.patokan,
      this.title,
      this.editMode,
      this.isMainAddress,
      this.idx});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController detailLokasi = TextEditingController();
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController noHp = TextEditingController();
  TextEditingController tag = TextEditingController();
  TextEditingController patokan = TextEditingController();
  final FocusNode detailLokasiFocusNode = FocusNode();
  final FocusNode namaLengkapFocusNode = FocusNode();
  final FocusNode noHpFocusNode = FocusNode();
  final FocusNode tagFocusNode = FocusNode();
  final FocusNode patokanFocusNode = FocusNode();
  final FocusNode closeFocusNode = FocusNode();
  bool setsMainAddress = false;
  late bool isMainAddress;
  List newAddress = [];

  @override
  void initState() {
    super.initState();
    isMainAddress = widget.isMainAddress;
  }

  @override
  void dispose() {
    detailLokasi.dispose();
    namaLengkap.dispose();
    noHp.dispose();
    tag.dispose();
    detailLokasiFocusNode.dispose();
    namaLengkapFocusNode.dispose();
    noHpFocusNode.dispose();
    tagFocusNode.dispose();
    closeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: showAppBar(),
      body: addAddressPage(),
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
            widget.title ?? "Alamat Baru",
            style: poppins.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget addAddressPage() {
    final addressprovider =
        Provider.of<AddressProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 14, top: 32),
        child: Column(
          children: [
            fieldMaker(
                context,
                'Detail Lokasi',
                widget.detailLokasi ?? 'Cth. blok, No.rumah, patokan',
                detailLokasi,
                focusNode: detailLokasiFocusNode,
                reqFocus: namaLengkapFocusNode,
                textInputAction: TextInputAction.next,
                prefilled: widget.detailLokasi),
            fieldMaker(context, 'Nama Lengkap',
                widget.namaLengkap ?? 'Masukkan nama lengkap', namaLengkap,
                focusNode: namaLengkapFocusNode,
                reqFocus: noHpFocusNode,
                textInputAction: TextInputAction.next,
                prefilled: widget.namaLengkap),
            fieldMaker(context, 'No. Handphone',
                widget.noHp ?? 'Masukan no. Handphone', noHp,
                focusNode: noHpFocusNode,
                reqFocus: tagFocusNode,
                inputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                prefilled: widget.noHp),
            fieldMaker(context, 'Tandai lokasi sebagai',
                widget.tag ?? 'Cth, rumah, kantor, kampus', tag,
                focusNode: tagFocusNode,
                reqFocus: patokanFocusNode,
                textInputAction: TextInputAction.next,
                prefilled: widget.tag),
            fieldMaker(context, 'Patokan',
                widget.patokan ?? 'Cth, warna rumah, warna pager', patokan,
                focusNode: patokanFocusNode,
                reqFocus: closeFocusNode,
                prefilled: widget.patokan),
            const SizedBox(height: 31),
            Row(
              children: [
                Text(
                  'Jadikan alamat utama',
                  style: poppins.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                widget.editMode
                    ? Switch(
                        value: isMainAddress,
                        activeColor: primary4,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: bright,
                        trackOutlineColor: MaterialStateProperty.resolveWith(
                          (final Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return primary4.withAlpha(5);
                            }

                            return bright;
                          },
                        ),
                        onChanged: (bool value) {
                          setState(() {
                            isMainAddress = !isMainAddress;
                            debugPrint(isMainAddress.toString());
                          });
                        })
                    : Switch(
                        value: setsMainAddress,
                        activeColor: primary4,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: bright,
                        trackOutlineColor: MaterialStateProperty.resolveWith(
                          (final Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return primary4.withAlpha(5);
                            }

                            return bright;
                          },
                        ),
                        onChanged: (bool value) {
                          setState(() {
                            setsMainAddress = !setsMainAddress;
                            debugPrint(setsMainAddress.toString());
                          });
                        })
              ],
            ),
            GestureDetector(
              onTap: () {
                if (widget.editMode) {
                  if (detailLokasi.text.isNotEmpty) {
                    newAddress.add(detailLokasi.text);
                  } else {
                    newAddress.add(widget.detailLokasi);
                  }
                  if (namaLengkap.text.isNotEmpty) {
                    newAddress.add(namaLengkap.text);
                  } else {
                    newAddress.add(widget.namaLengkap);
                  }
                  if (noHp.text.isNotEmpty) {
                    newAddress.add(noHp.text);
                  } else {
                    newAddress.add(widget.noHp);
                  }
                  if (tag.text.isNotEmpty) {
                    newAddress.add(tag.text);
                  } else {
                    newAddress.add(widget.tag);
                  }
                  if (patokan.text.isNotEmpty) {
                    newAddress.add(patokan.text);
                  } else {
                    newAddress.add(widget.patokan);
                  }
                  if (isMainAddress) {
                    addressprovider.editAddress(widget.idx, newAddress);
                    addressprovider
                        .setDefaultAddress(addressprovider.data.length - 1);
                  } else {
                    addressprovider.editAddress(widget.idx, newAddress);
                  }
                  showSnackBar(context, '${newAddress[3]} updated!');
                  Navigator.pop(context);
                } else {
                  if (setsMainAddress) {
                    newAddress.addAll([
                      detailLokasi.text,
                      namaLengkap.text,
                      noHp.text,
                      tag.text,
                      patokan.text
                    ]);
                    addressprovider.addNewAddress(newAddress);
                    addressprovider
                        .setDefaultAddress(addressprovider.data.length - 1);
                  } else {
                    newAddress.addAll([
                      detailLokasi.text,
                      namaLengkap.text,
                      noHp.text,
                      tag.text,
                      patokan.text
                    ]);
                    addressprovider.addNewAddress(newAddress);
                  }
                  showSnackBar(context, '${newAddress[3]} added!');
                  Navigator.pop(context);
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: primary4,
                  borderRadius: BorderRadius.circular(37),
                ),
                width: 335,
                height: 48,
                child: Center(
                  child: Text(
                    widget.editMode ? 'Edit alamat' : 'Konfirmasi alamat',
                    style: poppins.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: primary2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

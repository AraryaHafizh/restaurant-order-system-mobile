import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets.dart';

passwordCheck(context, username, email, password1, passowrd2) {
  bool isSame = password1 == passowrd2;
  if (isSame) {
    registerMe(context, username, email, password1);
  } else {
    summonDialog(context,
        customTitle: 'Password tidak sama',
        customSubtitle: 'Pastikan password yang anda masukkan sama.');
  }
}

registerMe(context, username, email, password) async {
  final userProvider = Provider.of<UserDataProvider>(context, listen: false);
  List data = [username, email, password];
  bool isRegister = await userProvider.userRegister(data);
  // bool isRegister = false;

  if (isRegister) {
    summonDialog(context,
            customTitle: 'Register berhasil',
            customSubtitle: 'Silahkan login dengan akun baru anda.')
        .then((_) {
      Navigator.pop(context);
    });
  } else {
    summonDialog(context,
        customTitle: 'Register Gagal',
        customSubtitle: 'Silahkan coba kembali nanti.');
    debugPrint('register tidak berhasil');
  }
}

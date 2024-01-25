import 'package:capstone_restaurant/pages/help/help_page.dart';
import 'package:capstone_restaurant/pages/profile/app_rating_page.dart';
import 'package:capstone_restaurant/pages/profile/change_password_page.dart';
import 'package:capstone_restaurant/pages/home/favorite_page.dart';
import 'package:capstone_restaurant/pages/profile/faq_page.dart';
import 'package:capstone_restaurant/pages/profile/my_account_page.dart';
import 'package:capstone_restaurant/pages/profile/address_page.dart';

List localUserData = [];
List searchHistory = [];

List catData = [
  ['Appetizer', 'assets/images/home/homePage/category/appetizer.png'],
  ['Dessert', 'assets/images/home/homePage/category/dessert.png'],
  ['Ala Carte', 'assets/images/home/homePage/category/alacarte.png'],
  ['Paket Hemat', 'assets/images/home/homePage/category/paket.png'],
  ['Minum', 'assets/images/home/homePage/category/minuman.png'],
  ['All Menu', 'assets/images/home/homePage/category/allmenu.png'],
];

List bannerImg = [
  'assets/images/home/homePage/banner/banner.png',
  'assets/images/home/homePage/banner/banner1.png',
  'assets/images/home/homePage/banner/banner2.png',
  'assets/images/home/homePage/banner/banner3.png',
  'assets/images/home/homePage/banner/banner4.png',
];

// ----------------------------

List accMenu = [
  [
    'Profil Saya',
    'Ubah informasi akun saya',
    'assets/images/icons/accPage/profil.png',
    const AccPage()
  ],
  [
    'Ubah Password',
    'Ubah password saya',
    'assets/images/icons/accPage/password.png',
    const ChangePassword()
  ],
  [
    'Lokasi',
    'Atur alamat pengiriman',
    'assets/images/icons/accPage/location.png',
    const AddressPage(isRebuild: false)
  ],
  [
    'Customer Service',
    'Hubungi kami jika ada masalah',
    'assets/images/icons/accPage/cs.png',
    const HelpPage(route: false)
  ],
  [
    'Favorit',
    'Lihat menu favorit saya',
    'assets/images/icons/accPage/fav.png',
    const FavoriteMenu()
  ],
];

List accExtraMenu = [
  [
    'Beri Rating Untuk Kami',
    'Lihat menu favorit saya',
    'assets/images/icons/accPage/rating.png',
    const AppRating()
  ],
  [
    'FAQ',
    'Frequently Asked Question',
    'assets/images/icons/accPage/faq.png',
    const FAQPage()
  ],
];

// ----------------------------

List orderStatusEvents = [
  [
    true,
    false,
    false,
    'Pesananmu telah masuk',
    'Pesanan masuk tanggal 10-11-23 pukul 11:18 wib',
    'assets/images/order/statusLogo.png'
  ],
  [
    false,
    false,
    false,
    'Pesananmu telah diterima',
    'Pesanan diterima tanggal 10-11-23 pukul 11:20 wib',
    'assets/images/order/statusLogo2.png'
  ],
  [
    false,
    false,
    false,
    'Pesananmu sedang disiapkan',
    'Pesananmu lagi kami masak nih',
    'assets/images/order/statusLogo3.png'
  ],
  [
    false,
    false,
    false,
    'Pesananmu sedang dipacking',
    'Sebentar ya, pesanamu sedang kami kemas agar kualitasnya tetap terjaga  ',
    'assets/images/order/statusLogo4.png'
  ],
  [
    false,
    false,
    false,
    'Pesananmu telah dikirim',
    'Pesananmu lagi diperjalanan nih, siap-siap ambil ya!',
    'assets/images/order/statusLogo5.png'
  ],
  [
    false,
    true,
    false,
    'Pesananmu telah sampai!',
    'Yeay, makanan mu sudah sampai!, selamat makan ya!',
    'assets/images/order/statusLogo6.png'
  ],
];

// ----------------------------

Map<String, dynamic> faqData = {
  'Pertanyaan Umum': {
    'icon': 'assets/images/icons/accPage/pertanyaanUmum.png',
    'tags': [
      'pertanyaan',
      'umum',
      'aplikasi',
      'layanan',
      'produk',
      'restoran',
      'layanan pelanggan',
      'troubleshooting'
    ],
    'questions': [
      [
        'Untuk Aplikasi ini:',
        'Selain menyediakan informasi tentang produk dan restoran, melalui aplikasi ini kami juga memberikan layanan terbaik untuk anda.'
      ],
      [
        'Jika aplikasi tidak berfungsi lakukan:',
        '1. Langkah pertama, matikan ponsel lalu nyalakan kembali.\n2. Jika tidak berhasil, hapus aplikasi anda\n3. Terakhir, hubungi layanan pelanggan kami.'
      ],
    ],
  },
  'Pembayaran & Profil': {
    'icon': 'assets/images/icons/accPage/pembayaranProfil.png',
    'tags': [
      'pembayaran',
      'profil',
      'metode',
      'ganti',
      'hubungi',
      'ganti password',
      'customer service',
      'metode pembayaran'
    ],
    'questions': [
      [
        'Bagaimana cara mengubah PIN di Aplikasi Alta Resto?',
        'Silahkan masuk ke akun kamu, pilih profil, pilih ubah Password, masukkan PIN lama, setelah itu silahkan masukkan PIN baru.'
      ],
      [
        'Bisa kah saya mengganti metode pembayaran di aplikasi Alta Resto ini?',
        'Selama pembayaran belum dilakukan, kamu bisa melakukan transaksi baru dan menggunakan metode pembayaran lainnya.'
      ],
      [
        'Apabila ada pertanyaan, siapa yang harus saya hubungi?',
        'Kamu bisa menghubungi Customer Service kami'
      ],
      [
        'Pembayaran seperti apa yang bisa saya lakukan di Alta Resto?',
        'Kakak bisa memilih pembayaran dengan menggunakan  E-wallet (Govay, dana, ovo, shopeepay), atau Bank (BCA, Permata Bank, BRI, Bank Mandiri, Cimb Niaga, Bank BTN)'
      ],
    ],
  },
  'Pick Up': {
    'icon': 'assets/images/icons/accPage/pickUp.png',
    'tags': [
      'pick up',
      'selesai',
      'transaksi',
      'refund',
      'transaksi pick up',
      'proses selesai',
      'pengembalian dana'
    ],
    'questions': [
      [
        'Pesanan sudah di Pick up namun di aplikasi belum selesai.',
        'Jika pesanan kamu di aplikasi belum selesai, mohon tunggu 1X24 jam maka pesanan kamu otomatis akan terselesaikan.'
      ],
      [
        'Bagaimana kalau saya tidak jadi pick up pesanan saya?',
        'Mohon maaf sekali untuk transaksi yang tidak dipick up maka akan dianggap hangus dan tidak bisa direfund.'
      ],
    ],
  },
};


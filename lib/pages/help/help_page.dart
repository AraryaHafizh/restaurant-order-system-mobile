import 'package:capstone_restaurant/style.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  final route;
  const HelpPage({super.key, required this.route});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: showAppBar(),
      body: helpPage(),
    );
  }

  showAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: GestureDetector(
        onTap: () {
          // Navigator.pushReplacementNamed(context, '/home');
          Navigator.pop(context);
        },
        child: Image.asset('assets/images/icons/backButton.png'),
      ),
    );
  }

  Widget helpPage() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: primary2,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          padding: const EdgeInsets.only(top: 55, bottom: 14, left: 14),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  widget.route
                      ? Navigator.pushReplacementNamed(context, '/home')
                      : Navigator.pop(context);
                  // Navigator.pushReplacementNamed(context, '/home');
                  // Navigator.pop(context);
                },
                child: Image.asset('assets/images/icons/backButton.png'),
              ),
              const SizedBox(width: 16),
              Image.asset(
                'assets/images/home/helpPage/csAvatar.png',
                height: 40,
                width: 40,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Customer Service',
                        style: poppins.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/images/icons/tick.png',
                        width: 20,
                      )
                    ],
                  ),
                  Text(
                    'Aktif',
                    style: poppins.copyWith(color: outline, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/home/helpPage/background.png'),
                      fit: BoxFit.fill)),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
              child: Column(
                children: [
                  Text('aaa'),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: primary2,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 17),
          child: Row(
            children: [
              Container(
                height: 35,
                width: 318,
                child: TextField(
                  // controller: question,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: moreBright,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(42)),
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(42)),
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                    ),
                    hintText: 'Ketik pesan...',
                    hintStyle: poppins.copyWith(fontSize: 14, color: outline),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

// Text(
//             "Customer Service",
//             style: poppins.copyWith(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 18), // Ganti warna teks "Lupa Password"
//           ),
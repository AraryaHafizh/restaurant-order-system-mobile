import 'package:capstone_restaurant/style.dart';
import 'package:capstone_restaurant/widgets.dart';
import 'package:flutter/material.dart';

class ReviewItem {
  int userRating = 0;
  List<bool> ratings = [false, false, false, false, false];
  TextEditingController textController = TextEditingController();
}

class InputRating extends StatefulWidget {
  final List data;
  final int qty;
  final String img;
  const InputRating(
      {super.key, required this.data, required this.qty, required this.img});

  @override
  State<InputRating> createState() => _InputRatingState();
}

class _InputRatingState extends State<InputRating> {
  bool isAnonim = false;
  int itemLen = 0;
  late List<ReviewItem> reviewItems;

  @override
  void initState() {
    super.initState();
    itemLen = widget.data.length;
    reviewItems = List.generate(itemLen, (index) => ReviewItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: showAppBar(),
      body: inputRatingPage(),
    );
  }

  void printUserReviews() {
    for (ReviewItem reviewItem in reviewItems) {
      debugPrint('Rating: ${reviewItem.userRating}');
      debugPrint('Review: ${reviewItem.textController.text}');
      debugPrint('---');
    }
  }

  showAppBar() {
    return AppBar(
      scrolledUnderElevation: 1,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.white,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset('assets/images/icons/closeW.png'),
      ),
    );
  }

  Widget inputRatingPage() {
    return SingleChildScrollView(
            child: Stack(
      children: [
        Container(
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.img),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 203),
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(56))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45, left: 25, right: 25),
                child: Column(
                  children: [
                    Text(
                      'Gimana makanannya?',
                      style: poppins.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Beri rating & ulasan menu yang kamu pesen yuk!',
                      style: poppins.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: outline),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 325),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: itemLen,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((BuildContext context, index) {
                  return reviewBoxMaker(reviewItems[index], widget.data[index]);
                }),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 22, right: 22, top: 14, bottom: 45),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Kirim secara anonim',
                        style: poppins.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: outline),
                      ),
                      const Spacer(),
                      Switch(
                          value: isAnonim,
                          activeColor: primary4,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: bright,
                          onChanged: (bool value) {
                            setState(() {
                              isAnonim = !isAnonim;
                            });
                          })
                    ],
                  ),
                  const SizedBox(height: 34),
                  GestureDetector(
                    onTap: () {
                      printUserReviews();
                      Navigator.pop(context);
                      showSnackBar(context, 'Terima kasih atas reviewnya!');
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
                          'Kirim',
                          style: poppins.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: primary2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ));
  }

  Widget reviewBoxMaker(reviewItem, data) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              data['name'],
              style:
                  poppins.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          for (int i = 0; i < reviewItem.ratings.length; i++) {
                            reviewItem.ratings[i] = i <= index;
                          }
                          reviewItem.userRating = index + 1;
                          debugPrint(
                              'rating dari user: ${reviewItem.userRating}');
                        });
                      },
                      child: Image.asset(
                        'assets/images/icons/star.png',
                        color: reviewItem.ratings[index] ? tertiary3 : surface,
                        width: 30,
                      ),
                    ));
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Tulis ulasanmu disini ya!',
              style:
                  poppins.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          TextField(
            controller: reviewItem.textController,
            decoration: userInputNote.copyWith(
              hintText: 'Contoh: Keasinan bang',
              hintStyle: poppins.copyWith(color: Colors.black45),
            ),
            maxLines: 6,
            maxLength: 4000,
            buildCounter: (BuildContext context,
                {int? currentLength, int? maxLength, bool? isFocused}) {
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    debugPrint('add photo tertekan');
                  },
                  child: Image.asset(
                    'assets/images/icons/add.png',
                    width: 20,
                  ),
                ),
                const SizedBox(width: 9),
                Text(
                  'Tambah Foto',
                  style: poppins.copyWith(fontSize: 14, color: outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

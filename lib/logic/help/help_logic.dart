import 'package:capstone_restaurant/data.dart';
import 'package:capstone_restaurant/logic/provider_handler.dart';
import 'package:capstone_restaurant/pages/home/popup_menu_page.dart';
import 'package:capstone_restaurant/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

const String apiKey = '';
bool isLoading = false;

Future<void> submit(context, question) async {
  final menuProvider = Provider.of<MenuDataProvider>(context, listen: false);
  final chatbot = Provider.of<ChatbotProvider>(context, listen: false);
  chatbot.updateLoadingState();

  try {
    final response =
        await dio.post('https://api.openai.com/v1/chat/completions',
            data: {
              'model': 'gpt-3.5-turbo',
              'messages': [
                {
                  'role': 'system',
                  'content':
                      'Anda adalah customer service di restoran bernama Alta-Resto. tolong bantu customer yang bertanya. jika user bertanya mengenai menu gunakan ${menuProvider.getKeys} sebagai sumber data. Jangan berikan rekomendasi menu selain dari data ${menuProvider.getKeys}.'
                },
                {'role': 'user', 'content': chatbot.input},
              ],
              'temperature': 0.75,
            },
            options: Options(headers: {
              'Authorization': 'Bearer $apiKey',
              'Content-Type': 'application/json',
              'Content-Length': '<calculated when request is sent>'
            }));
    if (response.statusCode == 200) {
      // print('menu: ${menuProvider.getMenu}');
      final data = response.data;
      chatbot.updateOutput(data['choices'][0]['message']['content']);
      chatbot.updateHistory();
    } else {
      throw Exception('Failed to load response');
    }
  } catch (e) {
    debugPrint('Error $e');
  } finally {
    chatbot.updateLoadingState();
  }
}

Widget qnaWindow(context) {
  final chatbot = Provider.of<ChatbotProvider>(context);
  final data = chatbot.history;

  return Expanded(
    child: isLoading
        ? Center(
            child: SizedBox(
                width: 45,
                height: 45,
                child: CircularProgressIndicator(
                  color: primary4,
                  strokeWidth: 6,
                )),
          )
        : Stack(children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/home/helpPage/background.png',
                  fit: BoxFit.cover,
                )),
            ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemCount: data.isEmpty ? 1 : chatbot.history.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          textBubble(
                            'Halo ${localUserData[0]}, saya bot customer service dari Alta-Resto, ada yang bisa kami bantu?',
                            tertiary3,
                            'left',
                          ),
                        ],
                      ),
                    );
                  } else {
                    final items = data[index - 1];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          textBubble(items[0], Colors.white, 'right'),
                          const SizedBox(height: 15),
                          textBubble(items[1], tertiary3, 'left'),
                        ],
                      ),
                    );
                  }
                }),
          ]),
  );
}

Widget textBubble(data, color, align) {
  return Align(
    alignment: align == 'left' ? Alignment.topLeft : Alignment.topRight,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: align == 'left'
            ? const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: align == 'left'
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Text(
              data,
              style: poppins.copyWith(
                color: Colors.black,
                fontSize: 17,
              ),
              textAlign: align == 'left' ? TextAlign.left : TextAlign.right,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget recommendationMenuMaker(context, data) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          PageTransition(
              child: PopUpMenuDetail(data: data),
              type: PageTransitionType.fade));
    },
    child: Padding(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 200,
        ),
        child: Container(
          width: 230,
          decoration: homePageMenuBuilder,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              SizedBox(
                  width: 209,
                  height: 149,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        data['image'],
                        fit: BoxFit.cover,
                      ))),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/icons/favW.png',
                      color: primary3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['name'],
                        style: poppins.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    Text('Rp ${data['price'].toString()}',
                        style: poppins.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: secondary3)),
                    Text(data['description'],
                        style: poppins.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: outline)),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      width: 37,
                      height: 18,
                      decoration: BoxDecoration(
                          color: yellow,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icons/star.png',
                              width: 9,
                              color: Colors.white,
                            ),
                            Text('4.5',
                                style: poppins.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: primary2)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('30 Min',
                        style: poppins.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: outline)),
                    const SizedBox(width: 8),
                    Text('• Best Menu',
                        style: poppins.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: outline)),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    ),
  );
}


//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Column(
//                       children: [
//                         textBubble(
//                             'Halo ${localUserData[0]}, saya bot customer servicedari Alta-Resto, ada yang bisa kami bantu?',
//                             tertiary3,
//                             'left')
//                       ],
//                     ),
//                   );
//                 } else {
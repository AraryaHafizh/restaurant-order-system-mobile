import 'package:capstone_restaurant/data.dart';
import 'package:capstone_restaurant/logic/help/help_logic.dart';
import 'package:capstone_restaurant/logic/url_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

class UserDataProvider with ChangeNotifier {
  List<String> userData = [];
  List<String> get getData => userData;

  Future<bool> userLogin(data) async {
    bool result = false;
    try {
      final response = await dio.get(userDataURL);
      if (response.statusCode == 200) {
        response.data.forEach((key, val) {
          if (val['email'] == data[0] && val['password'] == data[1]) {
            userData.addAll([
              val['username'],
              val['email'],
              val['phoneNumber'],
              val['dob'],
            ]);
            result = true;
          }
        });
        localUserData = userData;
        notifyListeners();
        return result;
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      debugPrint('Error $e');
      return false;
    }
  }

  Future<bool> userRegister(data) async {
    try {
      final response = await dio.patch(userDataURL, data: {
        data[0]: {
          "username": data[0],
          "email": data[1],
          "password": data[2],
        }
      });
      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> updatePassword(data) async {
    try {
      final response = await dio.patch(userDataURL, data: {
        data[0][0]: {
          "username": data[0][0],
          "email": data[0][1],
          "password": data[1],
          "phoneNumber": data[0][2],
          "dob": data[0][3],
        }
      });
      if (response.statusCode == 200) {
        notifyListeners();
        return true;
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      return false;
    }
  }
}

class MenuDataProvider with ChangeNotifier {
  List allMenuKeys = [];
  List allMenuValues = [];
  List get getKeys => allMenuKeys;
  List get getVal => allMenuValues;

  Future<List> getMenuAll() async {
    allMenuKeys.clear();
    allMenuValues.clear();
    try {
      final response = await dio.get(menuDataURL);
      if (response.statusCode == 200) {
        allMenuKeys.addAll(response.data.keys);
        allMenuValues.addAll(response.data.values);
        return response.data;
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      debugPrint('Failed to load data from API: $error');
      return [];
    }
  }

  Map getMenuDetails(req) {
    Map data = {};
    for (var i in allMenuValues) {
      if (i['name'] == req) {
        data = (i);
      }
    }
    return data;
  }

  List getMenuByCat(category) {
    List data = [];
    for (var i in allMenuValues) {
      if (category == 'All Menu') {
        data.add(i);
      } else {
        if (i['category'] == category) {
          data.add(i);
        }
      }
    }
    return data;
  }

  List searchFood(searchedFood) {
    List data = [];
    for (var food in allMenuValues) {
      if (food['name'].toLowerCase().contains(searchedFood.toLowerCase())) {
        data.add(food);
      }
    }
    return data;
  }
}

class ChatbotProvider with ChangeNotifier {
  String gptOutput = '';
  String userInput = '';
  List<dynamic> chatHistory = [];

  String get output => gptOutput;
  String get input => userInput;
  List<dynamic> get history => chatHistory;

  void updateLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void updateOutput(data) {
    gptOutput = data;
    notifyListeners();
  }

  void updateInput(data) {
    userInput = data;
    notifyListeners();
  }

  void updateHistory() {
    chatHistory.add([input, output]);
    notifyListeners();
  }

  void clearChat() {
    chatHistory.clear();
    notifyListeners();
  }

  void askGPT(context, data) async {
    updateInput(data);
    await submit(context, data);
  }
}

class OrderProvider with ChangeNotifier {
  List<dynamic> ongoingData = [];
  List<dynamic> historyData = [];
  List<dynamic> orderNotesData = [];
  List totalPrice = [];
  List totalQuantity = [];
  List<dynamic> get ongoing => ongoingData;
  List<dynamic> get history => historyData;
  List<dynamic> get notes => orderNotesData;
  List<dynamic> get price => totalPrice;
  List<dynamic> get quantity => totalQuantity;

  void placeOrder(List data, List msg, int price, int qty) {
    ongoingData.add(List.from(data));
    orderNotesData.add(List.from(msg));
    totalPrice.add(price);
    totalQuantity.add(qty);
    notifyListeners();
  }

  void orderFinished(int index) {
    if (index >= 0 && index < ongoingData.length) {
      historyData.add(ongoingData[index]);
      ongoingData.removeAt(index);

      notifyListeners();
    }
  }
}

class FavoritesMenuProvider with ChangeNotifier {
  List userFavMenu = [];
  List get favMenu => userFavMenu;

  void addToFav(menu) {
    if (userFavMenu.contains(menu)) {
      userFavMenu.remove(menu);
    } else {
      userFavMenu.add(menu);
    }
    notifyListeners();
  }
}

class CartHandler with ChangeNotifier {
  List userCart = [];
  List userNotes = [];
  int totalPrice = 0;
  int totalQuantity = 0;

  List get cart => userCart;
  List get notes => userNotes;
  int get price => totalPrice;
  int get quantity => totalQuantity;

  void addToCart(String name, int qty, String price) {
    String cleanPrice = price.replaceAll('.', '');
    int numericPrice = int.tryParse(cleanPrice) ?? 0;
    bool isItemExist = false;

    for (int i = 0; i < userCart.length; i++) {
      if (userCart[i]["name"] == name) {
        userCart[i]["quantity"] += qty;
        isItemExist = true;
        totalPrice += numericPrice;
        totalQuantity += qty;
        userCart[i]["price"] = numericPrice * userCart[i]["quantity"];
        break;
      }
    }

    if (!isItemExist) {
      userCart.add({
        "name": name,
        "quantity": qty,
        "price": numericPrice,
        'originalPrice': numericPrice
      });
      userNotes.add(null);
      totalPrice += numericPrice;
      totalQuantity += qty;
    }
    notifyListeners();
  }

  void incrementItem(String name, int price) {
    for (int i = 0; i < userCart.length; i++) {
      if (userCart[i]["name"] == name) {
        userCart[i]["quantity"] += 1;
        userCart[i]["price"] += price;
        totalPrice += price;
        totalQuantity += 1;
        notifyListeners();
        break;
      }
    }
  }

  void decrementItem(index, String name, int price) {
    for (int i = 0; i < userCart.length; i++) {
      if (userCart[i]["name"] == name) {
        if (userCart[i]["quantity"] > 1) {
          userCart[i]["quantity"] -= 1;
          userCart[i]["price"] -= price;
          totalPrice -= price;
          totalQuantity -= 1;
          notifyListeners();
        } else {
          userNotes.removeAt(index);
          totalPrice -= price;
          totalQuantity -= 1;

          userCart.removeAt(i);
          notifyListeners();
        }
        break;
      }
    }
  }

  void addNote(int index, String note) {
    userNotes[index] = note;
    notifyListeners();
  }

  void clearCart() {
    userCart.clear();
    userNotes.clear();
    totalPrice = 0;
    totalQuantity = 0;
    notifyListeners();
  }
}

class BannerProvider with ChangeNotifier {
  int currentIndex = 0;
  int get index => currentIndex;

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}

class AddressProvider with ChangeNotifier {
  List<dynamic> userAddress = [
    [
      'Jl. dulu aja no.13, Pondok Cabe, Jakarta Timur, Jawa Barat, Indonesia',
      'Hydre Dry',
      '081212348876',
      'Rumah',
      'Pagar hitam, depan taman, cat tembok abu.'
    ],
    [
      'Jl. di tengah malam, Pondok Gede, bekasi, Jawa Barat, Indonesia',
      'Tundra Doi',
      '081388651234',
      'Rumah II',
      'Pagar hijau, depan sungai, ada pohon.'
    ],
  ];
  int defaultAddress = 0;
  int get idx => defaultAddress;
  List<dynamic> get data => userAddress;

  void addNewAddress(data) {
    userAddress.add(data);
    notifyListeners();
  }

  void editAddress(idx, data) {
    userAddress[idx] = data;
    notifyListeners();
  }

  void setDefaultAddress(idx) {
    defaultAddress = idx;
    notifyListeners();
  }

  void deleteAddress(idx) {
    userAddress.removeAt(idx);
    notifyListeners();
  }
}

class OrderStatusDemoProvider with ChangeNotifier {
  List copyData = orderStatusEvents;
  List get data => copyData;
  bool orderFinished = false;
  bool get status => orderFinished;

  void resetOrderStatus() {
    for (int i = 0; i < orderStatusEvents.length; i++) {
      copyData[i][2] = false;
    }
  }

  Future<void> orderStatusDemo() async {
    orderFinished = false;
    for (int i = 0; i < orderStatusEvents.length; i++) {
      await Future.delayed(const Duration(seconds: 2));
      copyData[i][2] = true;
      notifyListeners();
    }
    orderFinished = true;
    notifyListeners();
  }
}

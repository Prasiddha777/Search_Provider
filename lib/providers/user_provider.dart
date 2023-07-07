import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:search_api/models/user_models.dart';

class UserProvider extends ChangeNotifier {
  UserModel userModel = UserModel(data: []);
  UserModel searchUserModel = UserModel(data: []);
  String searchText = "";
  String error = "";
  bool isLoading = true;

  getUserData() async {
    try {
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=2'),
      );
      if (response.statusCode == 200) {
        isLoading = false;
        final decodedResp = jsonDecode(response.body.toString());
        userModel = UserModel.fromJson(decodedResp);
      } else {
        isLoading = false;
        print(response.statusCode.toString());
      }
    } catch (e) {
      isLoading = false;
      error = e.toString();
    }
    //
    isLoading = false;
    getUpdatedData();
  }

  //searchapi datas;
  getUpdatedData() async {
    searchUserModel.data!.clear();
    if (searchText.isEmpty) {
      searchUserModel.data!.addAll(userModel.data!);
    } else {
      searchUserModel.data!.addAll(userModel.data!
          .where((element) =>
              element.firstName!.toLowerCase().startsWith(searchText))
          .toList());
    }
    notifyListeners();
  }

  search(String userName) {
    searchText = userName;
    getUpdatedData();
  }
}

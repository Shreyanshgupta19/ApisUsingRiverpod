
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/getUi3Model&UserIndexModel.dart';
import '../url/url.dart';

class getUi3Repo {
    final Dio _dio = Dio();

  Future<List<getUi3Model>?> fetchGetUi3Repo() async {
    try {
      var url = '${Url.baseUrl}${Url.endPoint3}'; // 'https://reqres.in/api/users/2';

      var response = await _dio.get(
        url,
      );
      if (kDebugMode) {
        print("url:$url");
        print("status code: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        // Map<String, dynamic> userData = jsonResponse['data'];
        // Map<String, dynamic> userSupport = jsonResponse['support'];
        getUi3Model user = getUi3Model.fromJson(jsonResponse);
        if (kDebugMode) {
          print("data:$user");
        }
        return [user];
      } else {
        throw [];
      }
    }on SocketException {
      throw 'No internet found';
    }
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // return [];
       throw 'Error: something went wrong error ${e.hashCode} outlook';
    }
  }


  Future<List<getUi3Model>?> fetchGetUi3IndexRepo({required int index}) async {
    try {
      var url = 'https://reqres.in/api/users/${index}'; // 'https://reqres.in/api/users/2';

      var response = await _dio.get(
        url,
      );
      if (kDebugMode) {
        print("url:$url");
        print("status code: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        // Map<String, dynamic> userData = jsonResponse['data'];
        // Map<String, dynamic> userSupport = jsonResponse['support'];
        getUi3Model user = getUi3Model.fromJson(jsonResponse);
        if (kDebugMode) {
          print("data:$user");
        }
        return [user];
      } else {
        throw [];
      }
    }on SocketException {
      throw 'No internet found';
    }
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // return [];
       throw 'Error: something went wrong error ${e.hashCode} outlook';
    }
  }
}
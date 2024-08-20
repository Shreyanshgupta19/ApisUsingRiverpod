import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_api_calling/getApi/url/url.dart';

import '../model/getUi2Model.dart';

class getUi2Repo {
  Future<List<getUi2Model>?> fetchGetUi2Repo() async {
    Dio dio = Dio();
    try {
      var url = '${Url.baseUrl}${Url.endPoint2}'; // 'https://reqres.in/api/users?delay=3';

      var response = await dio.get(url);
      if (kDebugMode) {
        print("url: $url");
        print("status code: ${response.statusCode}");
      }
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        if (jsonResponse.containsKey('data')) {
          // List<dynamic> dataList = jsonResponse['data'];
          List<getUi2Model> models = [getUi2Model.fromJson(jsonResponse)];

          if (kDebugMode) {
            print("data: $models");
          }
          return models;
        } else {
          throw 'Invalid response format';
        }
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

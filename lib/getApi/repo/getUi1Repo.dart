import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/getUi1Model.dart';


class getUi1Repo {
  final Dio dio = Dio();

  Future<List<getUi1Model>?> fetchGetUi1Repo() async {
    try {
      var url = 'https://jsonplaceholder.typicode.com/comments?postId=1';
      if(kDebugMode) {
        print("url:$url");
      }
      var response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        List<getUi1Model> comments = jsonResponse.map((data) => getUi1Model.fromJson(data)).toList();
        if(kDebugMode) {
          print("data: $comments");
        }
        return comments;
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
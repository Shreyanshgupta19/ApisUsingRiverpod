import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../model/getUi4Model.dart';

class getUi4Repo {
  final Dio dio = Dio();
  Future<List<getUi4Model>?> fetchGetUi4Repo() async {
    try {
      var url = 'https://freetestapi.com/api/v1/dogs?sort=name&order=';
      if(kDebugMode) {
        print("url : $url");
      }
      var response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        List<getUi4Model> comments = jsonResponse.map((data) => getUi4Model.fromJson(data)).toList();
        if(kDebugMode) {
          print("data: $comments");
        }
        return comments;
      } else {
        throw [];
      }
    } on SocketException {
      throw 'No internet found';
    }
      catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'Error: something went wrong error ${e.hashCode} outlook'; // return [];
    }
  }
}

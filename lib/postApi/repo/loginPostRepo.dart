import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_api_calling/getApi/url/url.dart';
import '../postModel/loginModel.dart';

class LoginRepo {
  Future<Response> loginRepo(LoginModel loginModel) async {
    try {
      Dio dio = Dio();
      var url = '${Url.baseUrl}${Url.endPointLogin}'; // 'https://reqres.in/api/login';
      var response = await dio.post(
        url,
        data: loginModel.toJson(),
      );
      if(response.statusCode == 200) {
        if (kDebugMode) {
          print("URL: $url");
          print("Status Code: ${response.statusCode}");
          print('Response Headers: ${response.headers}');
          print('Response Body: ${response.data}');
        }
        return response;
      } else {
        throw 'Nothing found';
      }
    } on SocketException {
      throw 'No internet found';
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'Error: something went wrong error ${e.hashCode} outlook';
    }
  }
}

// class LoginRepo {
//   Future<Response> loginRepo({required String email, required String password}) async {
//     try {
//       Dio dio = Dio();
//       var url = 'https://reqres.in/api/login';
//       final body = {
//         'email' : email,
//         'password' : password
//        };
//       var response = await dio.post(
//         url,
//         data: body,
//       );
//       if (kDebugMode) {
//         print("URL: $url");
//         print("Status Code: ${response.statusCode}");
//         print('Response Headers: ${response.headers}');
//         print('Response Body: ${response.data}');
//       }
//       return response;
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//       rethrow;
//     }
//   }
// }

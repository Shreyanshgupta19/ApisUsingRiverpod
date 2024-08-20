import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_calling/getApi/ui/getui1.dart';
import 'package:riverpod_api_calling/getApi/ui/getui2.dart';
import 'package:riverpod_api_calling/getApi/ui/getui3.dart';
import 'package:riverpod_api_calling/getApi/ui/getui4.dart';
import 'package:riverpod_api_calling/postApi/ui/loginUi.dart';

import 'getApi/ui/GetUserIndexData.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GetUiIndex(), // getui1(),// getui2(),// getui3(),// getui4(), // LoginUI() // GetUiIndex()
    );
  }
}



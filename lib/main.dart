import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_calling/DataPassing/Screen2.dart';
import 'package:riverpod_api_calling/getApi/ui/getui1.dart';
import 'package:riverpod_api_calling/getApi/ui/getui2.dart';
import 'package:riverpod_api_calling/getApi/ui/getui3.dart';
import 'package:riverpod_api_calling/getApi/ui/getui4.dart';
import 'package:riverpod_api_calling/postApi/ui/loginUi.dart';

import 'DataPassing/Screen1.dart';
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
      home: const GetUiIndex(), // getui1(),// getui2(),// getui3(),// getui4(), // LoginUI() // GetUiIndex() // Screen1() // Screen2()
    );
  }
}

// ref.invalidate(futureIndexProvider); // refreshing the ui
// ref.watch(futureIndexProvider(index)); // rebuilds the widget when value is change
// ref.read(futureIndexProvider(index)); // value is change only once
// ref.listen(futureIndexProvider(index),
// (previous, next) {},
// onError: (error, stackTrace) {},); // value is change without rebuilds the widget

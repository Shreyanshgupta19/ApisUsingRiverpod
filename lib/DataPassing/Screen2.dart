import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_api_calling/DataPassing/Screen1.dart';

class Screen2 extends ConsumerWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('builds');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
            child: Consumer(
              builder: (context, ref, child) {
                int ourData = ref.watch<int>(counterProvider);
                return Text(
                  '${ourData.toString()}',
                  style: TextStyle(fontSize: 54, color: Colors.black),
                );
              },
            )),
      ),
    );
  }
}

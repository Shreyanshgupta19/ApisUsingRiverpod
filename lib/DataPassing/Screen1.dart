import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_api_calling/DataPassing/Screen2.dart';

final counterProvider = StateProvider<int>(
   (ref) {
     return 0;
   },
);

class Screen1 extends ConsumerWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(kDebugMode) {
      print('builds');
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 1'),centerTitle: true,),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  int ourData = ref.watch<int>(counterProvider);
                  return Text(
                    '${ourData.toString()}',
                    style: TextStyle(fontSize: 54, color: Colors.black),
                  );
                },
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Screen2(),));
                }, child: const Text('Next Page')),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
      child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/getUi3Model&UserIndexModel.dart';
import '../repo/getUi3&UserIndexRepo.dart';

final futureIndexProvider = FutureProvider.autoDispose
    .family<List<getUi3Model>?, int>((ref, index) async { // <return type data, send type data>
  return await getUi3Repo().fetchGetUi3IndexRepo(index: index);
});

class GetUiIndex extends ConsumerStatefulWidget {
  const GetUiIndex({super.key});

  @override
  ConsumerState<GetUiIndex> createState() => _GetUiIndexState();
}

class _GetUiIndexState extends ConsumerState<GetUiIndex> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('builds');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Riverpod Get Api 3'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer(
              builder: (context, ref, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          labelText: 'Enter index',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                ElevatedButton(
                onPressed: () {
                final index = int.tryParse(controller.text) ?? 2;
                ref.invalidate(futureIndexProvider); // refreshing the ui
                ref.watch(futureIndexProvider(index)); // rebuilds the widget when value is change
                },
                child: const Text('Fetch Data'),
                ),
                  ],
                );
              }
          ),
          Consumer(
            builder: (context, ref, child) {
              final index = int.tryParse(controller.text) ?? 2;
              final asyncData = ref.watch(futureIndexProvider(index));
          
              return Expanded(
                child: asyncData.when(
                  data: (data) {
                    if (data == null || data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('No data found'),
                            TextButton(
                              onPressed: () {
                                ref.invalidate(futureIndexProvider(index));
                              },
                              child: const Text('Retry',
                                  style: TextStyle(color: Colors.blue)),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 8),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.library_books,
                                            color: Colors.black, size: 65),
                                        const SizedBox(width: 8),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].data.id?.toString() ?? ' ',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              data[index].support.url?.toString() ?? ' ',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              data[index].data.firstName?.toString() ?? ' ',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Error: ${error.toString()}'),
                          TextButton(
                            onPressed: () {
                              ref.invalidate(futureIndexProvider(index));
                            },
                            child: const Text('Retry',
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.blue));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

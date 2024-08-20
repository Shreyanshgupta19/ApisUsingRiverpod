// StateNotifier

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../riverpod/getUi3Riverpod.dart';
//
// class getui3 extends ConsumerWidget {
//   const getui3({super.key,});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     if(kDebugMode) {
//       print('builds');
//     }
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text('Riverpod get Api 3'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Consumer(builder: (context, ref, child) {
//           getUi3Riverpod state = ref.watch(get3ApiProvider);
//           // if(state is InitialGet2State){
//           //   return Text('Press button to fetch data');
//           // }
//           if(state is Get3LoadingPostState){
//             ref.read(get3ApiProvider.notifier).fetchPosts();
//             return Center(child: CircularProgressIndicator(color: Colors.blue,),);
//           }
//           if(state is ErrorGet3State){
//             print('Error: ${state.message}');
//             return Center(child: Column(
//               children: [
//                 Text(state.message),
//               ],
//             ));
//           }
//           if(state is Get3LoadedPostState){
//             return Column(children: [
//               Expanded(
//                   child: RefreshIndicator(
//                       color: Colors.blue,
//                       backgroundColor: Colors.white,
//                       onRefresh: () async {
//                         ref.read(get3ApiProvider.notifier).retryFetchPosts();
//                       },
//                       child: state.posts == {} || state.posts.isEmpty
//                           ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Text('No data found'),
//                             TextButton(onPressed: (){ref.read(get3ApiProvider.notifier).retryFetchPosts();}, child: Text('Retry',style: TextStyle(color: Colors.blue),)),
//                           ],
//                         ),
//                       )
//                           : ListView.builder(
//                           itemCount: state.posts.length,
//                           itemBuilder: (context, index) {
//                             ref.read(get3ApiProvider.notifier).fetchPosts();
//                             return Padding(
//                               padding: EdgeInsets.only(left: 8,right: 8,bottom: 8,),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     // height: size.setHeight(70),
//                                     margin: EdgeInsets.symmetric(
//                                         horizontal: 5,
//                                         vertical: 5),
//                                     padding: EdgeInsets.only(
//                                         left: 10,
//                                         top: 2,
//                                         bottom: 10,
//                                         right: 10),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(15)
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.library_books,color: Colors.black,size: 65,),
//                                         SizedBox(width: 8,),
//                                         Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               '${state.posts[index].data.id == null ? ' ': state.posts[index].data.id}',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             Text(
//                                               '${state.posts[index].support.url == null ? ' ': state.posts[index].support.url}',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                             ),
//                                             Text(
//                                               '${state.posts[index].data.firstName == null ? ' ': state.posts[index].data.firstName}',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           })
//                   )),
//             ]
//             );
//           }
//           return Center(child: Text('Nothing found'));
//         },),
//       ),
//     );
//   }
// }

// Future Provider

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/getUi3Model&UserIndexModel.dart';
import '../repo/getUi3&UserIndexRepo.dart';

final futureProvider3 = FutureProvider.autoDispose<List<getUi3Model>?>((ref) async {
  return await getUi3Repo().fetchGetUi3Repo();
});

class getui3 extends ConsumerWidget {
  const getui3({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('builds');
    }
    var asyncData = ref.watch(futureProvider3);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Riverpod get Api 3'),
        centerTitle: true,
      ),
      body: asyncData.when(
        data: (data) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    color: Colors.blue,
                    backgroundColor: Colors.white,
                    onRefresh: () async {
                      ref.invalidate(futureProvider3);
                    },
                    child:
                    data == null || data.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('No data found'),
                          TextButton(
                            onPressed: () {
                              ref.invalidate(futureProvider3);
                            },
                            child: const Text('Retry', style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                    )
                        :
                    ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {

                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  padding: const EdgeInsets.only(left: 10, top: 2, bottom: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.library_books, color: Colors.black, size: 65),
                                      const SizedBox(width: 8),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].data.id.toString() as String? ?? ' ',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            data[index].support.url.toString() as String? ?? ' ',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            data[index].data.firstName.toString() as String? ?? ' ',
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
                    ),
                  ),
                ),
              ],
            ),
          );
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
                    ref.invalidate(futureProvider3);
                  },
                  child: const Text('Retry', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator(color: Colors.blue));
        },
      ),
    );
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_calling/getApi/riverpod/getUi1Riverpod.dart';

class getui1 extends ConsumerWidget {
  const getui1({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(kDebugMode) {
      print('builds');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Riverpod get Api 1'),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          getUi1Riverpod state = ref.watch(get1ApiProvider);
          // if(state is InitialGetState){
          //   return Text('Press button to fetch data');
          // }
          if(state is Get1LoadingPostState){
            ref.read(get1ApiProvider.notifier).fetchPosts();
            return Center(child: CircularProgressIndicator(color: Colors.blue,),);
          }
          if(state is ErrorGet1State){
            print('Error: ${state.message}');
            return Center(child: Column(
              children: [
                Text(state.message),
            ],
            ));
          }
          if(state is Get1LoadedPostState){
            return Column(children: [
              Expanded(
                  child: RefreshIndicator(
                      color: Colors.blue,
                      backgroundColor: Colors.white,
                      onRefresh: () async {
                        ref.read(get1ApiProvider.notifier).retryFetchPosts();
                      },
                      child: state.posts == null || state.posts.isEmpty
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('No data found'),
                            TextButton(onPressed: (){ref.read(get1ApiProvider.notifier).retryFetchPosts();}, child: Text('Retry',style: TextStyle(color: Colors.blue),))
                          ],
                        ),
                      )
                          : ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            ref.read(get1ApiProvider.notifier).fetchPosts();
                            return Padding(
                              padding: EdgeInsets.only(left: 8,right: 8,bottom: 8,),
                              child: Column(
                                children: [
                                  Container(
                                    // height: size.setHeight(70),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 5),
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        top: 2,
                                        bottom: 10,
                                        right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.library_books,color: Colors.black,size: 65,),
                                        SizedBox(width: 8,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${state.posts[index].id == null ? ' ': state.posts[index].id}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                            ),
                                            Text(
                                              '${state.posts[index].postId == null ? ' ': state.posts[index].postId}',
                                              style: TextStyle(
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
                            );
                          }))),
            ]
            );
          }
          return Center(child: Text('Nothing found'));
        },),
      ),

    );
  }
}
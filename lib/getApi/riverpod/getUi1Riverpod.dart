import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/getUi1Model.dart';
import '../repo/getUi1Repo.dart';

final get1ApiProvider = StateNotifierProvider.autoDispose<Get1Notifier, getUi1Riverpod>(
  (ref) {
    return Get1Notifier();
  },
);

@immutable
abstract class getUi1Riverpod {}

// class InitialGetState extends getUi1Riverpod {}

class Get1LoadingPostState extends getUi1Riverpod {}

class Get1LoadedPostState extends getUi1Riverpod {
  Get1LoadedPostState({
    required this.posts,
  });

  List<getUi1Model> posts;
}

class ErrorGet1State extends getUi1Riverpod {
  ErrorGet1State({
    required this.message,
  });

  final String message;
}

class Get1Notifier extends StateNotifier<getUi1Riverpod> {
  Get1Notifier() : super(Get1LoadingPostState());  // InitialGetState()
  final getUi1Repo controller = getUi1Repo();

  void fetchPosts() async {
    try {
      // state = Get1LoadingPostState();
      List<getUi1Model>? posts = await controller.fetchGetUi1Repo();
      state = Get1LoadedPostState(posts: posts!);
    } catch (e) {
      state = ErrorGet1State(message: e.toString());
    }
  }

  void retryFetchPosts() async {
    try {
       state = Get1LoadingPostState();
      List<getUi1Model>? posts = await controller.fetchGetUi1Repo();
      state = Get1LoadedPostState(posts: posts!);
    } catch (e) {
      state = ErrorGet1State(message: e.toString());
    }
  }
}

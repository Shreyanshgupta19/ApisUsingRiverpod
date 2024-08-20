import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/getUi2Model.dart';
import '../repo/getUi2Repo.dart';

final get2ApiProvider = StateNotifierProvider.autoDispose<Get2Notifier, getUi2Riverpod>(
      (ref) {
    return Get2Notifier();
  },
);

@immutable
abstract class getUi2Riverpod {}

// class InitialGet2State extends getUi2Riverpod {}

class Get2LoadingPostState extends getUi2Riverpod {}

class Get2LoadedPostState extends getUi2Riverpod {
  Get2LoadedPostState({
    required this.posts,
  });

  List<getUi2Model> posts;
}

class ErrorGet2State extends getUi2Riverpod {
  ErrorGet2State({
    required this.message,
  });

  final String message;
}

class Get2Notifier extends StateNotifier<getUi2Riverpod> {
  Get2Notifier() : super(Get2LoadingPostState());  // InitialGet2State()
  final getUi2Repo controller = getUi2Repo();

  void fetchPosts() async {
    try {
      // state = Get2LoadingPostState();
      List<getUi2Model>? posts = await controller.fetchGetUi2Repo();
      state = Get2LoadedPostState(posts: posts!);
    } catch (e) {
      state = ErrorGet2State(message: e.toString());
    }
  }

  void retryFetchPosts() async {
    try {
      state = Get2LoadingPostState();
      List<getUi2Model>? posts = await controller.fetchGetUi2Repo();
      state = Get2LoadedPostState(posts: posts!);
    } catch (e) {
      state = ErrorGet2State(message: e.toString());
    }
  }
}

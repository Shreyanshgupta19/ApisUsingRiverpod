import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/getUi4Model.dart';
import '../repo/getUi4Repo.dart';

final get4ApiProvider = StateNotifierProvider.autoDispose<Get4Notifier, getUi4Riverpod>(
      (ref) {
    return Get4Notifier();
  },
);

@immutable
abstract class getUi4Riverpod {}

// class InitialGet4State extends getUi1Riverpod {}

class Get4LoadingPostState extends getUi4Riverpod {}

class Get4LoadedPostState extends getUi4Riverpod {
  Get4LoadedPostState({
    required this.posts,
  });

  List<getUi4Model> posts;
}

class ErrorGet4State extends getUi4Riverpod {
  ErrorGet4State({
    required this.message,
  });

  final String message;
}

class Get4Notifier extends StateNotifier<getUi4Riverpod> {
  Get4Notifier() : super(Get4LoadingPostState());  // InitialGet4State()
  final getUi4Repo controller = getUi4Repo();

  void fetchPosts() async {
    try {
      // state = Get1LoadingPostState();
      List<getUi4Model>? posts = await controller.fetchGetUi4Repo();
      state = Get4LoadedPostState(posts: posts!);
    } catch (e) {
      state = ErrorGet4State(message: e.toString());
    }
  }

  void retryFetchPosts() async {
    try {
      state = Get4LoadingPostState();
      List<getUi4Model>? posts = await controller.fetchGetUi4Repo();
      state = Get4LoadedPostState(posts: posts!);
    } catch (e) {
      state = ErrorGet4State(message: e.toString());
    }
  }
}

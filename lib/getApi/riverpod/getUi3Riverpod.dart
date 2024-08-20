import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_calling/getApi/model/getUi1Model.dart';
import 'package:riverpod_api_calling/getApi/repo/getUi1Repo.dart';
import '../model/getUi3Model&UserIndexModel.dart';
import '../repo/getUi3&UserIndexRepo.dart';

final get3ApiProvider = StateNotifierProvider.autoDispose<Get3Notifier, getUi3Riverpod>(
      (ref) {
    return Get3Notifier();
  },
);

@immutable
abstract class getUi3Riverpod {}

// class InitialGet3State extends getUi3Riverpod {}

class Get3LoadingPostState extends getUi3Riverpod {}

class Get3LoadedPostState extends getUi3Riverpod {
  Get3LoadedPostState({
    required this.posts,
  });

  List<getUi3Model> posts;
}

class ErrorGet3State extends getUi3Riverpod {
  ErrorGet3State({
    required this.message,
  });

  final String message;
}

class Get3Notifier extends StateNotifier<getUi3Riverpod> {
  Get3Notifier() : super(Get3LoadingPostState());  // InitialGet3State()
  final getUi3Repo controller = getUi3Repo();

  void fetchPosts() async {
    try {
      // state = Get3LoadingPostState();
      List<getUi3Model>? posts = await controller.fetchGetUi3Repo();
      state = Get3LoadedPostState(posts: posts!);
    } catch (e) {
      state = ErrorGet3State(message: e.toString());
    }
  }

  void retryFetchPosts() async {
    try {
      state = Get3LoadingPostState();
      List<getUi3Model>? posts = await controller.fetchGetUi3Repo();
      state = Get3LoadedPostState(posts: posts!);
    } catch (e) {
      state = ErrorGet3State(message: e.toString());
    }
  }
}
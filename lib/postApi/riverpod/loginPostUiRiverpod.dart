import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../postModel/loginModel.dart';
import '../repo/loginPostRepo.dart';

final postApiProvider = StateNotifierProvider.autoDispose<PostNotifier, PostState>(  // <return type data, send type data>
      (ref) {
    return PostNotifier();
  },
);

class PostState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  PostState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
  });

  factory PostState.initial() {
    return PostState(isLoading: false, isSuccess: false);
  }
}

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier() : super(PostState.initial());

  final LoginRepo controller = LoginRepo();

  Future<void> postApi(LoginModel loginModel) async {
    state = PostState(isLoading: true, isSuccess: false);
    try {
      var response = await controller.loginRepo(loginModel);

      if (response.statusCode == 200) {
        state = PostState(isLoading: false, isSuccess: true);
      } else {
        state = PostState(isLoading: false, isSuccess: false, error: 'Error: ${response.data["error"]}');
      }
    } catch (e) {
      state = PostState(isLoading: false, isSuccess: false, error: e.toString());
    }
  }
}

// StateNotifier

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../postModel/loginModel.dart';
import '../riverpod/loginPostUiRiverpod.dart';

class LoginUI extends ConsumerStatefulWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends ConsumerState<LoginUI> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print('builds');
    final postState = ref.watch(postApiProvider);

    ref.listen<PostState>(
      postApiProvider, (previous, next) {
      if (next.isSuccess) {
        emailController.clear();
        passwordController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextPage()),
        );
      }
      else if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
      },
     // onError: (error, stackTrace) {
     //  ScaffoldMessenger.of(context).showSnackBar(
     //    SnackBar(content: Text(error.toString())),
     //  );
     // },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post API with Riverpod'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: postState.isLoading
                  ? null
                  : () {
                final email = emailController.text;
                final password = passwordController.text;
                ScaffoldMessenger.of(context).clearSnackBars();
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email and Password cannot be empty')),
                  );
                  return;
                }

                final postModel = LoginModel(
                  email: email,
                  password: password,
                );
                ref.read(postApiProvider.notifier).postApi(postModel);
              },
              child: postState.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: const Center(
        child: Text('Navigation Successful!'),
      ),
    );
  }
}


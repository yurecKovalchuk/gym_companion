import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_in.dart';

const kButtonHeight = 64.0;
const kButtonRadius = 16.0;

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<SignInBloc, SignInState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  height: 32,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _password,
                  obscureText: state.obscureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(state.obscureText ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        state.obscureText ? bloc.hidePassword() : bloc.showPassword();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 80.0), // Spacer
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      bloc.getSignIn(_email.text, _password.text);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(kButtonHeight),
                        backgroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(46),
                        )),
                    child: state.status == SignInStatus.loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Sign In'),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Do not have an account? ',
                          style: textTheme.titleLarge!.copyWith(),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: textTheme.titleLarge!.copyWith(
                            color: colorScheme.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _navigatorPushToSignUpScreen(context);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.status == SignInStatus.success) {
          _navigatorPushToExerciseScreen(context);
        }
      },
    );
  }

  void _navigatorPushToSignUpScreen(BuildContext context) async {
    await Navigator.pushNamed(context, '/signUpScreen');
  }

  void _navigatorPushToExerciseScreen(BuildContext context) async {
    await Navigator.pushNamed(context, '/exercisesScreen');
  }
}

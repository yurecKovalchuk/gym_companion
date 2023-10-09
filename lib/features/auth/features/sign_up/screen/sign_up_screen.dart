import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SignUpBloc>(context);

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<SignUpBloc, SignUpState>(
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
                        text: 'Sign Up',
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
                TextField(
                  controller: _displayName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Full name',
                  ),
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
                      bloc.signUp(
                        _email.text,
                        _password.text,
                        _displayName.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(kButtonHeight),
                        backgroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(46),
                        )),
                    child: state.status == SignUpStatus.loading
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
                          text: 'Already have an account? ',
                          style: textTheme.titleLarge!.copyWith(),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _navigatorPushToSignInScreen(context);
                            },
                          text: 'Login',
                          style: textTheme.titleLarge!.copyWith(
                            color: colorScheme.primary,
                          ),
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
        if (state.status == SignUpStatus.success) {
          _navigatorPushToSignInScreen(context);
        }
      },
    );
  }

  void _navigatorPushToSignInScreen(BuildContext context) async {
    await Navigator.pushNamed(context, '/signInScreen');
  }
}

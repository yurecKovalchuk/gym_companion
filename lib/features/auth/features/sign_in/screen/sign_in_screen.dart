import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/app/app.dart';
import 'package:timer_bloc/localization/localization.dart';
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
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _navigatorPushWelcomeScreen(context);
              },
            ),
            title: Text(context.l10n.projectName),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: context.l10n.login,
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
                  maxLength: 30,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: context.l10n.email,
                    hintText: 'example@example.com',
                    errorText: state.isEmailValid ? null : context.l10n.notCorrectEmail,
                  ),
                  onChanged: (email) => bloc.isEmailValid(email),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _password,
                  obscureText: state.obscureText,
                  maxLength: 20,
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
                    labelText: context.l10n.password,
                    errorText: state.isPasswordValid ? null : context.l10n.notCorrectPassword,
                  ),
                  onChanged: (password) => bloc.isPasswordValid(password),
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
                        : Text(context.l10n.login),
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
                          text: '${context.l10n.doNotHaveAccount} ',
                          style: textTheme.titleLarge!.copyWith(),
                        ),
                        TextSpan(
                          text: context.l10n.signUp,
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
        if (state.status == SignInStatus.error) {
          final snackBar = SnackBar(content: Text(state.error ?? 'Something happen'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }

  void _navigatorPushToSignUpScreen(BuildContext context) async {
    await Navigator.pushReplacementNamed(
      context,
      routSignUpScreen,
    );
  }

  void _navigatorPushToExerciseScreen(BuildContext context) async {
    await Navigator.pushReplacementNamed(
      context,
      routExerciseScreen,
    );
  }

  void _navigatorPushWelcomeScreen(BuildContext context) async {
    await Navigator.pushReplacementNamed(
      context,
      routWelcomeScreen,
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/localization/localization.dart';
import '../../../../../app/app.dart';
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
          resizeToAvoidBottomInset: false,
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
                        text: context.l10n.signUp,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                Column(
                  children: [
                    TextField(
                      controller: _displayName,
                      maxLength: 40,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: context.l10n.name,
                      ),
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
                          errorText: state.isEmailValid ? null : context.l10n.notCorrectEmail),
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
                  ],
                ),
                const Spacer(), // Spacer
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: ElevatedButton(
                    onPressed: () => bloc.signUp(
                      _email.text,
                      _password.text,
                      _displayName.text,
                    ),
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
                        : Text(context.l10n.signUp),
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
                          text: '${context.l10n.alreadyHaveAccount} ',
                          style: textTheme.titleLarge!.copyWith(),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _navigatorPushToSignInScreen(context);
                            },
                          text: context.l10n.login,
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
        if (state.status == SignUpStatus.error) {
          final snackBar = SnackBar(content: Text(state.error ?? 'Something happen'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }

  void _navigatorPushToSignInScreen(BuildContext context) async {
    await Navigator.pushReplacementNamed(
      context,
      routSignInScreen,
    );
  }

  void _navigatorPushWelcomeScreen(BuildContext context) async {
    await Navigator.pushReplacementNamed(
      context,
      routWelcomeScreen,
    );
  }
}

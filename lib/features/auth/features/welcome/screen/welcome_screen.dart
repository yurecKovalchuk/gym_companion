import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/localization/localization.dart';
import '../../../../../app/app.dart';
import '../../../auth.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${context.l10n.welcomeTo} ',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        TextSpan(
                          text: context.l10n.projectName,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _navigatorPushToSignInScreen(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(kButtonHeight),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kButtonRadius),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      context.l10n.login,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _navigatorPushToSignUpScreen(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(kButtonHeight),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kButtonRadius),
                      ),
                    ),
                    child: Text(
                      context.l10n.createAccount,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${context.l10n.byContinueYouAgree} ',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                        ),
                        TextSpan(
                          text: context.l10n.titlePrivacyPolicy,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              PrivacyPolicyDialog.show(context);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigatorPushToSignInScreen(BuildContext context) async {
    await Navigator.pushNamed(context, routSignInScreen);
  }

  void _navigatorPushToSignUpScreen(BuildContext context) async {
    await Navigator.pushNamed(context, routSignUpScreen);
  }
}

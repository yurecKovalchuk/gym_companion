import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/app/app.dart';

import '../bloc/bloc.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DrawerBloc>(context);

    return BlocConsumer<DrawerBloc, DrawerState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Side Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Setting'),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text('Log out'),
                onTap: () {
                  bloc.logOutAccount();
                },
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state.status == DrawerStatus.logOutSuccess) {
          _navigatorPushToWelcomeScreen(context);
        }
      },
    );
  }

  void _navigatorPushToWelcomeScreen(BuildContext context) async {
    await Navigator.pushReplacementNamed(
      context,
      routWelcomeScreen,
    );
  }
}

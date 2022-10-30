import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/cubit/user_provider_cubit.dart';
import 'package:flutterglobal/View/Menu/menu_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserProviderCubit, UserProviderState>(
        bloc: context.watch<UserProviderCubit>(),
        listenWhen: (previous, current) {
          return previous.isLoading != current.isLoading;
        },
        listener: (context, state) {
          if (!state.isLoading) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MenuView(),
              ),
            );
          }
        },
        child: Container(
          decoration: Utils.instance
              .backgroundDecoration(ImageEnums.background, fit: BoxFit.fill),
          child: Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

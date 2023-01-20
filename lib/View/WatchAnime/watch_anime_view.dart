import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_cubit.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_state.dart';

class WatchAnimeView extends StatelessWidget {
  WatchAnimeView({super.key});

  var bloc = WatchAnimeCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Anime izle"),
      ),
      body: Container(
        width: context.width,
        height: context.height,
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: BlocBuilder<WatchAnimeCubit, WatchAnimeState>(
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          bloc: context.read<WatchAnimeCubit>(),
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: Text("Watch anime"));
          },
        ),
      ),
    );
  }
}

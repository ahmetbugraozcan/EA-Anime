import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';

import 'cubit/stickers_cubit.dart';

class StickersView extends StatelessWidget {
  StickersView({super.key});
  var cubit = StickersCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: BlocBuilder<StickersCubit, StickersState>(
            bloc: cubit,
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                    child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ));
              } else {
                return ListView.builder(
                  itemCount: state.stickerPacks?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        cubit.downloadStickers();
                      },
                      title: Text(
                        state.stickerPacks?[index].animeName ?? "",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        state.stickerPacks?[index].stickerUrls.toString() ?? "",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

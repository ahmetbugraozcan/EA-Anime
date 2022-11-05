import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
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
                  physics: BouncingScrollPhysics(),
                  itemCount: state.stickerPacks?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          cubit.downloadStickers(state.stickerPacks![index]);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state
                                    .stickerPacks![index].stickerUrls!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 80, crossAxisCount: 3),
                                itemBuilder: (context, i) {
                                  return Center(
                                    child: Image.network(
                                      state
                                          .stickerPacks![index].stickerUrls![i],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(state.stickerPacks![index].name!,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(
                                            color: Colors.grey.shade300)),
                              ),
                            ],
                          ),
                        ),
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

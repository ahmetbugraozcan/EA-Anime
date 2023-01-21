import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_cubit.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_state.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/watch_anime_details_view.dart';

class WatchAnimeView extends StatelessWidget {
  WatchAnimeView({super.key});

  var bloc = WatchAnimeCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
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
              previous.isLoading != current.isLoading ||
              previous.animeEpisodeList != current.animeEpisodeList,
          bloc: context.read<WatchAnimeCubit>(),
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.animeEpisodeList.isEmpty) {
              return Center(child: Text("Anime listesi boş"));
            }
            return SafeArea(
              child: GridView.builder(
                  itemCount: state.animeEpisodeList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WatchAnimeDetailsView()));
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                    placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    imageUrl: state.animeEpisodeList[index]
                                            .thumbnail ??
                                        ""),
                                // child: Image.network(
                                //   state.animeEpisodeList[index].thumbnail ?? "",
                                //   fit: BoxFit.fill,
                                // ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 3.0),
                                child: Text(
                                    state.animeEpisodeList[index].title ?? ""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}

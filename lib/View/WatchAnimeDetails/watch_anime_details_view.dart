import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/anime_episode.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_cubit.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui';

class WatchAnimeDetailsView extends StatelessWidget {
  // AnimeEpisode animeEpisode;
  WatchAnimeDetailsCubit cubit;
  WatchAnimeDetailsView({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: BlocBuilder<WatchAnimeDetailsCubit, WatchAnimeDetailsState>(
          bloc: cubit,
          builder: (context, state) {
            return Text(
                "${state.animeEpisode.title} - ${state.animeEpisode.episodeNumber}. Bölüm");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WatchAnimeDetailsCubit, WatchAnimeDetailsState>(
          bloc: cubit,
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: context.width,
                  height: context.height / 3,
                  child: WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setBackgroundColor(const Color(0x00000000))
                        ..setNavigationDelegate(
                          NavigationDelegate(
                            onProgress: (int progress) {
                              // Update loading bar.
                            },
                            onPageStarted: (String url) {},
                            onPageFinished: (String url) {},
                            onWebResourceError: (WebResourceError error) {},
                            onNavigationRequest: (NavigationRequest request) {
                              return NavigationDecision.navigate;
                            },
                          ),
                        )
                        ..loadRequest(Uri.dataFromString(
                            '<html><body><iframe width="${window.physicalSize.width}" height="100%" src="${cubit.animeEpisode.links?.first.url}" frameborder="0" scrolling="no" allowfullscreen></iframe></body></html>',
                            mimeType: 'text/html'))),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

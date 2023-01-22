import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterglobal/Core/Extensions/context_extensions.dart';

import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_cubit.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'dart:ui';

class WatchAnimeDetailsView extends StatelessWidget {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: context.width,
                  height: context.height / 3,
                  child: Stack(
                    children: [
                      BlocBuilder<WatchAnimeDetailsCubit,
                              WatchAnimeDetailsState>(
                          bloc: cubit,
                          buildWhen: (previous, current) =>
                              previous.isWebViewLoading !=
                              current.isWebViewLoading,
                          builder: ((context, state) {
                            return Visibility(
                              visible: state.isWebViewLoading,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          })),
                      WebViewWidget(
                          controller: WebViewController()
                            ..setJavaScriptMode(JavaScriptMode.unrestricted)
                            ..setBackgroundColor(const Color(0x00000000))
                            ..setNavigationDelegate(
                              NavigationDelegate(
                                onProgress: (int progress) {
                                  // Update loading bar.
                                },
                                onPageStarted: (String url) {
                                  // Show loading bar.
                                },
                                onPageFinished: (String url) {
                                  // Hide loading bar.
                                  cubit.setIsWebViewLoading(false);
                                },
                                onWebResourceError: (WebResourceError error) {},
                                onNavigationRequest:
                                    (NavigationRequest request) {
                                  return NavigationDecision.navigate;
                                },
                              ),
                            )
                            ..loadRequest(Uri.dataFromString(
                                '<html><body><iframe width="${window.physicalSize.width}" height="100%" src="${cubit.animeEpisode.links?.first.url}" frameborder="0" scrolling="no" allowfullscreen></iframe></body></html>',
                                mimeType: 'text/html'))),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent.shade100,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Önceki Bölüm"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Sonraki Bölüm"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text("Bölüm Açıklaması",
                      style: context.textTheme.headlineSmall),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    state.animeEpisode.description ?? " Açıklama mevcut değil.",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

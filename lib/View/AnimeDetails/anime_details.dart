import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Models/anime.dart';

class AnimeDetails extends StatelessWidget {
  Anime? anime;
  AnimeDetails({super.key, this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anime Detay"),
      ),
      body: Builder(builder: (context) {
        if (anime == null) return SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    width: context.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.network(
                      anime?.thumbnail ?? "",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anime?.title ?? "-",
                          style: context.textTheme.titleLarge,
                        ),
                        Text(
                          "${anime!.episodesCount ?? "-"} Bölüm",
                          style: context.textTheme.bodySmall,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Text(
                                anime!.myAnimeListScore == null
                                    ? "-"
                                    : anime!.myAnimeListScore.toString() +
                                        "/10",
                              ),
                              Icon(Icons.star, color: Colors.yellow),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Builder(builder: (context) {
                if (anime!.genres == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return Wrap(
                  children: List.generate(
                    anime!.genres!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Chip(
                        backgroundColor: Colors.primaries[index % 16],
                        label: Text(
                          anime!.genres![index],
                          style: context.textTheme.bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                anime?.description ?? "-",
                style: context.textTheme.titleSmall,
              ),
            ),

            // related animes

            // studios
          ],
        );
      }),
    );
  }
}

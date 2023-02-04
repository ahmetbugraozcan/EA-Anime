import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';

import 'package:flutterglobal/Models/anime_episode.dart';

class AnimeEpisodeCard extends StatelessWidget {
  AnimeEpisode? animeEpisode;
  bool? isHighlighted;
  VoidCallback? onTap;
  AnimeEpisodeCard(
      {super.key, this.animeEpisode, this.onTap, this.isHighlighted});

  @override
  Widget build(BuildContext context) {
    if (animeEpisode == null) return SizedBox();
    return ListTile(
      tileColor: isHighlighted ?? false ? Colors.lightBlue.shade100 : null,
      onTap: onTap,
      title: Text(
        Utils.instance.getAnimeEpisodeTitle(animeEpisode),
        style: context.textTheme.titleMedium,
      ),
      subtitle: Text(
        animeEpisode?.description ?? "Açıklama mevcut değil.",
        style: context.textTheme.bodySmall,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}

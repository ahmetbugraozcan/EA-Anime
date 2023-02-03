import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:marquee/marquee.dart';

class AnimeCard extends StatelessWidget {
  VoidCallback? onTap;
  String? imageUrl;
  String? title;

  AnimeCard({super.key, this.onTap, this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width / 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                      imageUrl: imageUrl ?? ""),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.0),
                  child: SizedBox(
                      height: 15,
                      width: double.infinity,
                      child: Builder(
                        builder: (context) {
                          if (title == null) {
                            return Text("");
                          } else if (title!.length > 20) {
                            return Marquee(
                              text: title!,
                              style: context.textTheme.bodyText1,
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 20.0,
                              velocity: 100.0,
                              pauseAfterRound: Duration(milliseconds: 3000),
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                            );
                          } else {
                            return Text(
                              title!,
                              style: context.textTheme.bodyText1,
                            );
                          }
                        },
                      )),
                  // child: Text(
                  //   title ?? "",
                  //   // maxLines: 1,
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

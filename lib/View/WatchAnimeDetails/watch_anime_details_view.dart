import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';

class WatchAnimeDetailsView extends StatelessWidget {
  const WatchAnimeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Anime izle"),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: context.width,
        height: context.height,
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: Text("Anime detay"),
      ),
    );
  }
}

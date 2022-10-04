import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Service/wallpaper_manager_service.dart';

class WallpaperSetButton extends StatelessWidget {
  Function(WallpaperType)? onSelected;
  WallpaperSetButton({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<WallpaperType>(
      position: PopupMenuPosition.under,
      onSelected: onSelected,
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (context) => WallpaperType.values
          .map((e) => PopupMenuItem<WallpaperType>(
                value: e,
                child: Text("${Utils.instance.getWallpaperTypeString(e)}"),
              ))
          .toList(),
    );
  }
}

import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageDownloaderService {
  static ImageDownloaderService? _instance;
  static ImageDownloaderService get instance {
    return _instance ??= ImageDownloaderService._init();
  }

  ImageDownloaderService._init();

  Future<bool> downloadImage(String url) async {
    try {
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        return false;
      }
      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);

      print('fileName: $fileName');
      print('path: $path');
      print('size: $size');
      print('mimeType: $mimeType');
      return true;
    } on PlatformException catch (error) {
      print(error);
      return false;
    }
  }
}

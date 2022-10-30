import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_stickers_plus/exceptions.dart';
import 'package:whatsapp_stickers_plus/whatsapp_stickers.dart';

class StickersService {
  static StickersService? _instance;

  static StickersService get instance => _instance ?? StickersService._init();

  StickersService._init();

  Future installFromRemote(List<String> stickerUrls) async {
    const stickers = {
      '01_Cuppy_smile.webp': ['☕', '🙂'],
      '02_Cuppy_lol.webp': ['😄', '😀'],
      '03_Cuppy_rofl.webp': ['😆', '😂'],
      '04_Cuppy_sad.webp': ['😃', '😍'],
      '05_Cuppy_cry.webp': ['😭', '💧'],
      '06_Cuppy_love.webp': ['😍', '♥'],
      '07_Cuppy_hate.webp': ['💔', '👎'],
      '08_Cuppy_lovewithmug.webp': ['😍', '💑'],
      '09_Cuppy_lovewithcookie.webp': ['😘', '🍪'],
      '10_Cuppy_hmm.webp': ['🤔', '😐'],
      '11_Cuppy_upset.webp': ['😱', '😵'],
      '12_Cuppy_angry.webp': ['😡', '😠'],
      '13_Cuppy_curious.webp': ['❓', '🤔'],
      '14_Cuppy_weird.webp': ['🌈', '😜'],
      '15_Cuppy_bluescreen.webp': ['💻', '😩'],
      '16_Cuppy_angry.webp': ['😡', '😤'],
      '17_Cuppy_tired.webp': ['😩', '😨'],
      '18_Cuppy_workhard.webp': ['😔', '😨'],
      '19_Cuppy_shine.webp': ['🎉', '✨'],
      '20_Cuppy_disgusting.webp': ['🤮', '👎'],
      '21_Cuppy_hi.webp': ['🖐', '🙋'],
      '22_Cuppy_bye.webp': ['🖐', '👋'],
    };

    var applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    log(applicationDocumentsDirectory.toString());

    var stickersDirectory =
        Directory('${applicationDocumentsDirectory.path}/stickers');
    await stickersDirectory.create(recursive: true);

    final dio = Dio();
    final downloads = <Future>[];

    stickerUrls.forEach((sticker) {
      downloads.add(
        dio.download(
          sticker,
          '${stickersDirectory.path}/$sticker',
        ),
      );
    });

    await Future.wait(downloads);

    var stickerPack = WhatsappStickers(
      identifier: 'cuppyFlutterWhatsAppStickers',
      name: 'Cuppy Flutter WhatsApp Stickers',
      publisher: 'John Doe',
      trayImageFileName: WhatsappStickerImage.fromAsset('assets/images/10.jpg'),
      publisherWebsite: '',
      privacyPolicyWebsite: '',
      licenseAgreementWebsite: '',
    );

    stickers.forEach((sticker, emojis) {
      stickerPack.addSticker(
          WhatsappStickerImage.fromFile('${stickersDirectory.path}/$sticker'),
          emojis);
    });

    try {
      await stickerPack.sendToWhatsApp();
    } on WhatsappStickersException catch (e) {
      print(e.cause);
    }
  }
}

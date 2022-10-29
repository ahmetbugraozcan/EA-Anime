import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  PackageInfo? packageInfo;
  static PackageInfoService _instance = PackageInfoService._init();
  static PackageInfoService get instance => _instance;

  PackageInfoService._init();

  static init() async {
    _instance.packageInfo ??= await PackageInfo.fromPlatform();
  }
}

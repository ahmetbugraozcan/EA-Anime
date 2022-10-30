import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/cubit/user_provider_cubit.dart';
import 'package:flutterglobal/Provider/guessingGames/guessing_games_cubit.dart';
import 'package:flutterglobal/Provider/language/cubit/language_provider_cubit.dart';
import 'package:flutterglobal/Provider/network/cubit/network_provider_cubit.dart';
import 'package:flutterglobal/Provider/testgame/cubit/test_game_selection_cubit.dart';
import 'package:flutterglobal/Provider/wallpaper/cubit/wallpaper_cubit.dart';
import 'package:flutterglobal/Provider/wallpaperRoot/cubit/wallpaper_root_cubit.dart';

class AllProviders {
  static AllProviders _instance = AllProviders._init();

  static AllProviders get instance => _instance;

  AllProviders._init();

  List<BlocProvider> dependItems() => [
        BlocProvider<UserProviderCubit>(
          create: (context) => UserProviderCubit(),
        ),
        BlocProvider<NetworkProviderCubit>(
          create: (context) => NetworkProviderCubit(),
        ),
        BlocProvider<AdsProviderCubit>(
          lazy: false,
          create: (context) => AdsProviderCubit(),
        ),
        BlocProvider<TestGameSelectionCubit>(
          create: (context) => TestGameSelectionCubit(),
        ),
        BlocProvider<WallpaperCubit>(
          create: (context) => WallpaperCubit(),
        ),
        BlocProvider<WallpaperRootCubit>(
          create: (context) => WallpaperRootCubit(),
        ),
        BlocProvider<GuessingGamesCubit>(
          create: (context) => GuessingGamesCubit(),
        ),
        BlocProvider<LanguageProviderCubit>(
          create: (context) => LanguageProviderCubit(),
        ),
      ];
}

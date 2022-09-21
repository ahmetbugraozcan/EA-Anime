import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/cubit/app_provider_cubit.dart';
import 'package:flutterglobal/Provider/network/cubit/network_provider_cubit.dart';

class AllProviders {
  static AllProviders _instance = AllProviders._init();

  static AllProviders get instance => _instance;

  AllProviders._init();

  List<BlocProvider> dependItems() => [
        BlocProvider<AppProviderCubit>(
          create: (context) => AppProviderCubit(),
        ),
        BlocProvider<NetworkProviderCubit>(
          create: (context) => NetworkProviderCubit(),
        ),
        BlocProvider<AdsProviderCubit>(
          lazy: false,
          create: (context) => AdsProviderCubit(),
        ),
      ];
}

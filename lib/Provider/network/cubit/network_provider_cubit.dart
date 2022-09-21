import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Service/connectivity_service.dart';
import 'package:meta/meta.dart';

part 'network_provider_state.dart';

class NetworkProviderCubit extends Cubit<NetworkProviderState> {
  ConnectivityService _connectivityService = ConnectivityService.instance;
  NetworkProviderCubit() : super(NetworkProviderState()) {
    listenNetworkStatus();
  }

  listenNetworkStatus() {
    _connectivityService.subscription.listen((event) {
      if (event == ConnectivityResult.none) {
        emit(state.copyWith(networkStatus: NetworkStatus.OFFLINE));
      } else {
        emit(state.copyWith(networkStatus: NetworkStatus.ONLINE));
      }
    });
  }
}

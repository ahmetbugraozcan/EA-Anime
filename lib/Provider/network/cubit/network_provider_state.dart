part of 'network_provider_cubit.dart';

enum NetworkStatus { OFFLINE, ONLINE }

class NetworkProviderState extends Equatable {
  NetworkStatus networkStatus;

  NetworkProviderState({this.networkStatus = NetworkStatus.OFFLINE});

  NetworkProviderState copyWith({NetworkStatus? networkStatus}) {
    return NetworkProviderState(
      networkStatus: networkStatus ?? this.networkStatus,
    );
  }

  @override
  List<Object?> get props => [networkStatus];
}

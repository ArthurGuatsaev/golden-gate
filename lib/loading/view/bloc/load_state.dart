// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'load_bloc.dart';

class LoadState {
  final List<VLoading> loadingList;
  final StatusLoadState status;
  final VFailed failed;
  final String url;
  final int onboardIndex;
  LoadState({
    this.onboardIndex = 0,
    this.url = '',
    this.loadingList = const [],
    this.failed = const VFailed(message: ''),
    this.status = StatusLoadState.initial,
  });

  LoadState copyWith({
    List<VLoading>? loadingList,
    StatusLoadState? status,
    int? onboardIndex,
    VFailed? failed,
    String? url,
  }) {
    return LoadState(
        loadingList: loadingList ?? this.loadingList,
        status: status ?? this.status,
        url: url ?? this.url,
        onboardIndex: onboardIndex ?? this.onboardIndex,
        failed: failed ?? this.failed);
  }
}

enum StatusLoadState { initial, loading, success, failed }

part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure }

class HomeState extends Equatable {
  const HomeState(
      {this.pageBlocks = const [],
      this.error,
      this.status = HomeStatus.initial,
      this.isFetching = false});
  final List<PageBlock> pageBlocks;
  final String? error;
  final HomeStatus status;
  final bool isFetching;

  @override
  List<Object?> get props => [pageBlocks, status, error, isFetching];

  HomeState copyWith({
    List<PageBlock>? pageBlocks,
    String? error,
    HomeStatus? status,
    bool? isFetching,
  }) {
    return HomeState(
      pageBlocks: pageBlocks ?? this.pageBlocks,
      error: error ?? this.error,
      status: status ?? this.status,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  String toString() {
    return '''HomeState {
      pageBlocks: ${pageBlocks.length},
      status: $status,
      error: $error,
      isFetching: $isFetching,
    }''';
  }
}

part of 'page_block_bloc.dart';

enum PageBlockStatus { initial, success, failure }

class PageBlockState extends Equatable {
  const PageBlockState(
      {this.pageBlocks = const [],
      this.error,
      this.status = PageBlockStatus.initial,
      this.isFetching = false});
  final List<PageBlock> pageBlocks;
  final String? error;
  final PageBlockStatus status;
  final bool isFetching;

  @override
  List<Object?> get props => [pageBlocks, status, error, isFetching];

  PageBlockState copyWith({
    List<PageBlock>? pageBlocks,
    String? error,
    PageBlockStatus? status,
    bool? isFetching,
  }) {
    return PageBlockState(
      pageBlocks: pageBlocks ?? this.pageBlocks,
      error: error ?? this.error,
      status: status ?? this.status,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  String toString() {
    return '''PageBlockState {
      pageBlocks: ${pageBlocks.length},
      status: $status,
      error: $error,
      isFetching: $isFetching,
    }''';
  }
}

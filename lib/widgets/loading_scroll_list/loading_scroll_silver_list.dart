import 'package:demo/helpers/all.dart';
import 'package:demo/widgets/loading_scroll_list/loading_silver_list.dart';
import 'package:demo/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';

class LoadingScrollSilverList<T> extends StatelessWidget {
  const LoadingScrollSilverList({
    Key? key,
    required this.data,
    required this.hasReachedMax,
    required this.isFetching,
    required this.onScrollEnd,
    required this.onScrollTop,
    required this.loadMore,
    required this.itemBuilder,
    this.emptyWidget,
    this.loadingContainerWidget,
    this.noMoreDataWidget,
    this.loadMoreWidget,
    this.loadingIndicatorWidget,
  }) : super(key: key);
  final List<T> data;
  final bool hasReachedMax;
  final bool isFetching;
  final Function() onScrollEnd;
  final Function() onScrollTop;
  final Function() loadMore;
  final Widget Function(T) itemBuilder;
  final Widget? emptyWidget;
  final Widget? loadingContainerWidget;
  final Widget? loadingIndicatorWidget;
  final Widget? noMoreDataWidget;
  final Widget? loadMoreWidget;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: CustomScrollController(
        onScrollTop: onScrollTop,
        onScrollEnd: onScrollEnd,
      ),
      slivers: [
        if (data.isEmpty) emptyWidget ?? const NoDataWidget(),
        if (data.isNotEmpty)
          LoadingSilverList<T>(data: data, itemBuilder: itemBuilder),
        SliverToBoxAdapter(
          child: Center(
              child: loadingContainerWidget ??
                  TextButton(
                    onPressed: hasReachedMax ? null : loadMore,
                    child: isFetching
                        ? loadingIndicatorWidget ??
                            const CircularProgressIndicator()
                        : hasReachedMax
                            ? noMoreDataWidget ?? const Text('No more data')
                            : loadMoreWidget ?? const Text('Load More'),
                  )),
        ),
      ],
    );
  }
}

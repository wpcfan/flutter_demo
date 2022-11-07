import 'package:flutter/material.dart';

class InfiniteScrollList<T> extends StatefulWidget {
  const InfiniteScrollList({super.key});

  @override
  State<InfiniteScrollList<T>> createState() => _InfiniteScrollListState<T>();
}

class _InfiniteScrollListState<T> extends State<InfiniteScrollList<T>> {
  late bool lastPage;
  late int pageNumber;
  late bool error;
  late int pageSize;
  late List<T> data;
  late bool isLoading;
  late bool isRefreshing;
  late ScrollController scrollController;
  late Future<void> Function() _fetchData;
  late Future<void> Function() _refreshData;
  late Widget Function(BuildContext, int) _itemBuilder;
  late Widget Function(BuildContext) _emptyBuilder;
  late Widget Function(BuildContext) _errorBuilder;
  late Widget Function(BuildContext) _loadingBuilder;

  @override
  void initState() {
    super.initState();
    pageNumber = 0;
    data = [];
    isLoading = false;
    isRefreshing = false;
    lastPage = false;
    error = false;
    pageSize = 10;
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      var nextPageTrigger = scrollController.position.maxScrollExtent * 0.9;
      if (scrollController.position.pixels > nextPageTrigger) {
        _fetchData();
      }
      var refreshTrigger = scrollController.position.minScrollExtent;
      if (scrollController.position.pixels < refreshTrigger) {
        _refreshData();
      }
    });
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        if (data.isEmpty) {
          return _emptyBuilder(context);
        } else if (index < data.length) {
          return _itemBuilder(context, index);
        } else if (error) {
          return _errorBuilder(context);
        } else {
          return _loadingBuilder(context);
        }
      },
      childCount: data.length + 1,
    ));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

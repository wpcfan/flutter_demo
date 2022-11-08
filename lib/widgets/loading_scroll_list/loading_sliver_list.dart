import 'package:flutter/material.dart';

class LoadingSliverList<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(T) itemBuilder;
  const LoadingSliverList(
      {super.key, required this.data, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        final item = data[index];
        return itemBuilder(item);
      },
      childCount: data.length,
    ));
  }
}

abstract class LoadingSilverItem<T> extends StatelessWidget {
  final T item;
  const LoadingSilverItem({super.key, required this.item});
}

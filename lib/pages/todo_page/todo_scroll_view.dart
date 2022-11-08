part of '../todo_page.dart';

class TodoScrollView extends StatelessWidget {
  const TodoScrollView({
    Key? key,
    required this.todos,
    required this.hasReachedMax,
    required this.isFetching,
    required this.onScrollEnd,
    required this.onScrollTop,
    required this.loadMore,
  }) : super(key: key);
  final List<Todo> todos;
  final bool hasReachedMax;
  final bool isFetching;
  final Function() onScrollEnd;
  final Function() onScrollTop;
  final Function() loadMore;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: CustomScrollController(
        onScrollTop: onScrollTop,
        onScrollEnd: onScrollEnd,
      ),
      slivers: [
        if (todos.isEmpty) const NoDataWidget(),
        if (todos.isNotEmpty) TodoListWidget(todos: todos),
        SliverToBoxAdapter(
          child: Center(
              child: TextButton(
            onPressed: hasReachedMax ? null : loadMore,
            child: isFetching
                ? const CircularProgressIndicator()
                : hasReachedMax
                    ? const Text('No more data')
                    : const Text('Load More'),
          )),
        ),
      ],
    );
  }
}

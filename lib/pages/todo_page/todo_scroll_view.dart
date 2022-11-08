part of '../todo_page.dart';

class TodoScrollView extends StatelessWidget {
  const TodoScrollView({
    Key? key,
    required this.todos,
    required this.hasReachedMax,
    required this.isFetching,
  }) : super(key: key);
  final List<Todo> todos;
  final bool hasReachedMax;
  final bool isFetching;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: CustomScrollController(
        onScrollTop: () => context.read<TodoBloc>().add(TodoRefreshEvent()),
        onScrollEnd: () => context.read<TodoBloc>().add(TodoFetchedEvent()),
      ),
      slivers: [
        if (todos.isEmpty) const NoDataWidget(),
        if (todos.isNotEmpty) TodoListWidget(todos: todos),
        SliverToBoxAdapter(
          child: Center(
              child: TextButton(
            onPressed: hasReachedMax
                ? null
                : () => context.read<TodoBloc>().add(TodoFetchedEvent()),
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

class CustomScrollController extends ScrollController {
  final Function() onScrollEnd;
  final Function() onScrollTop;
  final double scrollEndThreshold;
  final double scrollEndOffset;
  final double scrollTopOffset;

  CustomScrollController(
      {this.scrollEndThreshold = 1.0,
      this.scrollEndOffset = 0.0,
      this.scrollTopOffset = 0.0,
      required this.onScrollTop,
      required this.onScrollEnd});

  @override
  void notifyListeners() {
    super.notifyListeners();
    var maxScroll = position.maxScrollExtent * scrollEndThreshold;
    if (position.pixels >= maxScroll + scrollEndOffset) {
      onScrollEnd();
    }
    if (position.pixels <= -scrollTopOffset) {
      onScrollTop();
    }
  }
}

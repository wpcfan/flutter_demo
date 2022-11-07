import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/todo_bloc.dart';
import 'package:demo/repositories/all.dart';
import 'package:demo/widgets/no_data_widget.dart';
import 'package:demo/widgets/skeletons/all.dart';
import 'package:demo/widgets/todo_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget implements AutoRouteWrapper {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) => SafeArea(child: reducer(context, state)),
    );
  }

  Widget reducer(BuildContext context, TodoState state) {
    switch (state.status) {
      case TodoStatus.initial:
        return const SkeletonListView();
      case TodoStatus.success:
        return state.todos.isEmpty
            ? const NoDataWidget()
            : CustomScrollView(
                controller: CustomScrollController(
                  onScrollTop: () =>
                      context.read<TodoBloc>().add(TodoRefreshEvent()),
                  onScrollEnd: () =>
                      context.read<TodoBloc>().add(TodoFetchedEvent()),
                ),
                slivers: [
                  if (state.todos.isEmpty) const NoDataWidget(),
                  if (state.todos.isNotEmpty)
                    TodoListWidget(todos: state.todos),
                  SliverToBoxAdapter(
                    child: Center(
                        child: TextButton(
                      onPressed: state.hasReachedMax
                          ? null
                          : () =>
                              context.read<TodoBloc>().add(TodoFetchedEvent()),
                      child: state.hasReachedMax
                          ? const Text('No more data')
                          : const Text('Load More'),
                    )),
                  ),
                ],
              );
      case TodoStatus.failure:
        return Center(
          child: Text(state.error ?? 'Unknow Error'),
        );
    }
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider<TodoBloc>(
        create: (context) =>
            TodoBloc(repository: context.read<TodoRepository>())
              ..add(TodoFetchedEvent()),
        child: this,
      ),
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

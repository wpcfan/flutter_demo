import 'package:auto_route/auto_route.dart';
import 'package:demo/bloc/todo_bloc.dart';
import 'package:demo/helpers/all.dart';
import 'package:demo/models/all.dart';
import 'package:demo/repositories/all.dart';
import 'package:demo/widgets/no_data_widget.dart';
import 'package:demo/widgets/skeletons/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'todo_page/todo_list_item.dart';

part './todo_page/todo_list_widget.dart';
part './todo_page/todo_scroll_view.dart';

class TodoPage extends StatelessWidget implements AutoRouteWrapper {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) => SafeArea(child: reducer(context, state)),
    );
  }

  Widget reducer(BuildContext context, TodoState state) {
    final bloc = context.read<TodoBloc>();
    switch (state.status) {
      case TodoStatus.initial:
        return const SkeletonListView();
      case TodoStatus.success:
        return state.todos.isEmpty
            ? const NoDataWidget()
            : RefreshIndicator(
                color: Colors.white,
                backgroundColor: Colors.blue,
                strokeWidth: 4.0,
                child: TodoScrollView(
                  todos: state.todos,
                  hasReachedMax: state.hasReachedMax,
                  isFetching: state.isFetching,
                  onScrollTop: () {},
                  onScrollEnd: () => bloc.add(TodoFetchedEvent()),
                  loadMore: () => bloc.add(TodoFetchedEvent()),
                ),
                onRefresh: () async {
                  bloc.add(TodoRefreshEvent());
                  bloc.stream
                      .firstWhere((state) => state.isRefreshing == false);
                });
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

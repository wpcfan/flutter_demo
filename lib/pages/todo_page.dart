import 'package:auto_route/auto_route.dart';
import 'package:demo/repositories/all.dart';
import 'package:demo/states/todo_cubit.dart';
import 'package:demo/widgets/no_data_widget.dart';
import 'package:demo/widgets/skeletons/all.dart';
import 'package:demo/widgets/todo_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget implements AutoRouteWrapper {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) => SafeArea(child: reducer(context, state)),
      buildWhen: (previous, current) => current is TodoLoaded,
    );
  }

  Widget reducer(BuildContext context, TodoState state) {
    if (state is TodoLoading && state.todos!.isEmpty) {
      return const SkeletonListView();
    } else if (state is TodoLoaded) {
      return CustomScrollView(
        controller: CustomScrollController(
          onScrollTop: () => context.read<TodoCubit>().refresh(),
          onScrollEnd: () => context
              .read<TodoCubit>()
              .getTodos(page: state.page! + 1, limit: state.limit!),
        ),
        slivers: [
          if (state.todos!.isEmpty) const NoDataWidget(),
          if (state.todos!.isNotEmpty) TodoListWidget(todos: state.todos!),
          SliverToBoxAdapter(
            child: Center(
                child: TextButton(
              onPressed: () => context
                  .read<TodoCubit>()
                  .getTodos(page: state.page! + 1, limit: state.limit!),
              child: const Text('Load More'),
            )),
          ),
        ],
      );
    } else if (state is TodoError) {
      return Center(child: Text(state.message ?? 'Unknow Error'));
    } else {
      return const NoDataWidget();
    }
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider<TodoCubit>(
        create: (context) =>
            TodoCubit(repository: context.read<TodoRepository>()),
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

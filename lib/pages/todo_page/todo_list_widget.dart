part of '../todo_page.dart';

class TodoListWidget extends StatelessWidget {
  final List<Todo> todos;
  const TodoListWidget({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        final todo = todos[index];
        return TodoListItem(todo: todo);
      },
      childCount: todos.length,
    ));
  }
}

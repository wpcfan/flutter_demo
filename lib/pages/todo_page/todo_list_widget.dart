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
        return ListTile(
          title: Text(todo.title),
          trailing: Checkbox(
            value: todo.completed,
            onChanged: (value) =>
                context.read<TodoBloc>().add(TodoToggleEvent(todo: todo)),
          ),
        );
      },
      childCount: todos.length,
    ));
  }
}

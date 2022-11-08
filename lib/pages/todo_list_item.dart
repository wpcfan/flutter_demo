part of 'todo_page.dart';

class TodoListItem extends LoadingSilverItem<Todo> {
  const TodoListItem({super.key, required Todo item}) : super(item: item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      trailing: Checkbox(
        value: item.completed,
        onChanged: (value) =>
            context.read<TodoBloc>().add(TodoToggleEvent(todo: item)),
      ),
    );
  }
}

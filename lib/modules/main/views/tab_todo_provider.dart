import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/bloc/todo/todo_cubit.dart';
import 'package:flutter_demo_app/helper/todo_filter.dart';
import 'package:flutter_demo_app/modules/main/widgets/bottom_loader.dart';
import 'package:flutter_demo_app/modules/main/widgets/todo_item.dart';
class TodoProvider extends StatelessWidget {
  const TodoProvider({super.key, required this.filter});

  final TodoFilter filter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: TodoByStatus(filter: filter),
    );
  }
}

class TodoByStatus extends StatefulWidget {
  const TodoByStatus({super.key, required this.filter});

  final TodoFilter filter;

  @override
  State<TodoByStatus> createState() => _TodoByStatusState();
}

class _TodoByStatusState extends State<TodoByStatus>
    with AutomaticKeepAliveClientMixin<TodoByStatus> {
  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    context.read<TodoCubit>().getTodos(filter: widget.filter);

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(_onScroll);
  }

  // on scroll
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<TodoCubit>().getTodos(filter: widget.filter);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        if (state.status == TodoStateStatus.loading && state.isFirstLoad) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == TodoStateStatus.failure) {
          return const Text('Error');
        }
        final todos = state.todos;
        return RefreshIndicator(
          onRefresh: () async {
            context.read<TodoCubit>().clearTodos();
            context.read<TodoCubit>().getTodos(filter: widget.filter);
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: todos.length + (state.hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index == todos.length) {
                return const BottomLoader();
              } else {
                return TodoItem(todo: todos[index]);
              }
            },
          ),
        );
      },
    );
  }
}

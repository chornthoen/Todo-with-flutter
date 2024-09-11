import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/helper/todo_filter.dart';
import 'package:flutter_demo_app/models/todo_model.dart';
import 'package:flutter_demo_app/repository/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState());

  final TodoRepository _repository = TodoRepository();

  int _page = 1;

  Future<void> getTodos({TodoFilter filter = TodoFilter.all}) async {
    if (state.status == TodoStateStatus.loading) return;

    var oldTodos = <Todo>[];
    bool hasReachedMax = false;
    var currentState = state;

    if (currentState.status == TodoStateStatus.success) {
      oldTodos = currentState.todos;
      hasReachedMax = currentState.hasReachedMax;
    }

    emit(
      currentState.copyWith(
        status: TodoStateStatus.loading,
        todos: oldTodos,
        isFirstLoad: _page == 1,
      ),
    );

    if (hasReachedMax) {
      emit(
        currentState.copyWith(
          status: TodoStateStatus.success,
          todos: oldTodos,
          hasReachedMax: true,
        ),
      );
    }

    if (hasReachedMax) return;

    try {
      final todos = await _repository.getTodos(
        userId: switch (filter) {
          TodoFilter.all => 1,
          TodoFilter.pending => 2,
          TodoFilter.completed => 3,
          TodoFilter.draft => 4,
          _ => 1,
        },
        page: _page,
      );

      var newTodos = switch (state.status) {
        TodoStateStatus.loading => [...oldTodos],
        _ => <Todo>[],
      };

      newTodos.addAll(todos);

      emit(
        currentState.copyWith(
          status: TodoStateStatus.success,
          todos: newTodos,
          hasReachedMax: todos.isEmpty,
        ),
      );

      _page++;
    } catch (e) {
      emit(
        state.copyWith(status: TodoStateStatus.failure, error: e.toString()),
      );
    }
  }

  void clearTodos() {
    _page = 1;
    emit(TodoState());
  }
}

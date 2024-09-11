part of 'todo_cubit.dart';

enum TodoStateStatus { initial, loading, success, failure }

class TodoState extends Equatable {
  final TodoStateStatus status;
  final List<Todo> todos;
  final String? error;
  final bool isFirstLoad;
  final bool hasReachedMax;

  const TodoState({
    this.status = TodoStateStatus.initial,
    this.todos = const [],
    this.error,
    this.isFirstLoad = true,
    this.hasReachedMax = false,
  });

  TodoState copyWith({
    TodoStateStatus? status,
    List<Todo>? todos,
    String? error,
    bool? isFirstLoad,
    bool? hasReachedMax,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      error: error ?? this.error,
      isFirstLoad: isFirstLoad ?? this.isFirstLoad,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        todos,
        error,
        isFirstLoad,
        hasReachedMax,
      ];
}

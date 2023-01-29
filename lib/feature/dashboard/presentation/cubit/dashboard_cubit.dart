import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_24_hour/feature/dashboard/domain/entity/task.dart';
import 'package:the_24_hour/feature/dashboard/domain/usecase/list_tasks_by_day.dart';
import 'package:the_24_hour/product/init/language/locale_keys.g.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._listTasksByDay) : super(const DashboardState.initial());

  final ListTasksByDay _listTasksByDay;

  Future<void> getTasksByDay(ListTaskParams params) async {
    emit(state.copyWith(isLoading: true));
    final failureOrTasks = await _listTasksByDay.run(params);
    failureOrTasks.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: LocaleKeys.errors_network_serverFailure.tr(),
        ),
      ),
      (data) => emit(state.copyWith(isLoading: false, tasks: data)),
    );
  }
}

@immutable
class DashboardState extends Equatable {
  const DashboardState({
    required this.isLoading,
    this.tasks,
    this.errorMessage,
  });

  const DashboardState.initial()
      : isLoading = false,
        tasks = null,
        errorMessage = null;

  final bool isLoading;
  final Iterable<Task>? tasks;
  final String? errorMessage;

  @override
  List<Object?> get props => [isLoading, tasks, errorMessage];

  DashboardState copyWith({
    bool? isLoading,
    Iterable<Task>? tasks,
    String? errorMessage,
  }) {
    return DashboardState(
      isLoading: isLoading ?? false,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage,
    );
  }
}

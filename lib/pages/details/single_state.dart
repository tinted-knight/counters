import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class SingleState extends BlocState {
  final bool isLoading;
  final bool hasLoaded;
  final bool isSaving;
  final bool isDeleting;
  final bool hasDone;
  final bool hasCanceled;
  final bool validationError;
  final bool colorHasUpdated;
  final CounterItem counter;
  final CounterItem counterWithErrors;

  SingleState(
      {this.isLoading = false,
      this.hasLoaded = false,
      this.isSaving = false,
      this.isDeleting = false,
      this.hasDone = false,
      this.hasCanceled = false,
      this.validationError = false,
      this.colorHasUpdated = false,
      this.counter,
      this.counterWithErrors});

  factory SingleState.loading() => SingleState(isLoading: true);

  factory SingleState.done() => SingleState(hasDone: true);

  SingleState canceled() => this.copyWith(hasCanceled: true);

  SingleState deleting() => this.copyWith(isDeleting: true);

  factory SingleState.colorUpdated(CounterItem item) => SingleState(
        colorHasUpdated: true,
        counter: item,
      );

  factory SingleState.loaded(CounterItem item) => SingleState(
        hasLoaded: true,
        counter: item,
      );

  SingleState copyWith({
    bool isLoading,
    bool hasLoaded,
    bool isSaving,
    bool isDeleting,
    bool hasDone,
    bool hasCanceled,
    bool validationError,
    bool colorHasUpdated,
    CounterItem counter,
    CounterItem counterWithErrors,
  }) =>
      SingleState(
        isLoading: isLoading ?? this.isLoading,
        hasLoaded: hasLoaded ?? this.hasLoaded,
        isSaving: isSaving ?? this.isSaving,
        isDeleting: isDeleting ?? this.isDeleting,
        hasDone: hasDone ?? this.hasDone,
        hasCanceled: hasCanceled ?? this.hasCanceled,
        validationError: validationError ?? this.validationError,
        colorHasUpdated: colorHasUpdated ?? this.colorHasUpdated,
        counter: counter ?? this.counter,
        counterWithErrors: counterWithErrors ?? this.counterWithErrors,
      );
}

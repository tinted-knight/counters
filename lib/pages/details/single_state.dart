import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class SingleState extends BlocState {
  final bool isLoading;
  final bool hasLoaded;
  final bool isSaving;
  final bool hasSaved;
  final bool hasCanceled;
  final bool validationError;
  final CounterItem counter;
  final CounterItem counterWithErrors;

  SingleState(
      {this.isLoading = false,
      this.hasLoaded = false,
      this.isSaving = false,
      this.hasSaved = false,
      this.hasCanceled = false,
      this.validationError = false,
      this.counter,
      this.counterWithErrors});

  factory SingleState.loading() => SingleState(isLoading: true);

  factory SingleState.saving() => SingleState(isSaving: true);

  factory SingleState.saved() => SingleState(hasSaved: true);

  SingleState canceled() => this.copyWith(hasCanceled: true);

  factory SingleState.loaded(CounterItem item) => SingleState(
        hasLoaded: true,
        counter: item,
      );

  SingleState copyWith({
    bool isLoading,
    bool hasLoaded,
    bool isSaving,
    bool hasSaved,
    bool hasCanceled,
    bool validationError,
    CounterItem counter,
    CounterItem counterWithErrors,
  }) =>
      SingleState(
        isLoading: isLoading ?? this.isLoading,
        hasLoaded: hasLoaded ?? this.hasLoaded,
        isSaving: isSaving ?? this.isSaving,
        hasSaved: hasSaved ?? this.hasSaved,
        hasCanceled: hasCanceled ?? this.hasCanceled,
        validationError: validationError ?? this.validationError,
        counter: counter ?? this.counter,
        counterWithErrors: counterWithErrors ?? this.counterWithErrors,
      );
}

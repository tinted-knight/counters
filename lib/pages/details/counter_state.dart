import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/cupertino.dart';

class SingleCounterState extends BlocState {
  SingleCounterState({
    this.counter,
    this.isSaving = false,
    @required this.isLoading,
    this.loaded = false,
    this.hasSaved = false,
    this.hasFailed = false,
    this.validationError = false,
  });

  final bool isLoading;
  final bool loaded;
  final bool isSaving;
  final bool hasSaved;
  final bool hasFailed;
  final bool validationError;
  final CounterItem counter;

  factory SingleCounterState.loading() => SingleCounterState(isLoading: true);

  factory SingleCounterState.loaded(CounterItem item) => SingleCounterState(
        counter: item,
        isLoading: false,
      );

  factory SingleCounterState.saving() => SingleCounterState(isSaving: true, isLoading: false);

  factory SingleCounterState.validationError() => SingleCounterState(
        isLoading: false,
        validationError: true,
      );

  factory SingleCounterState.failed() => SingleCounterState(
        isSaving: false,
        hasFailed: true,
        isLoading: false,
      );

  factory SingleCounterState.saved() => SingleCounterState(
        isSaving: false,
        hasSaved: true,
        isLoading: false,
      );
}

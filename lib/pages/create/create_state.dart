import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

class CreateState extends BlocState {
  final bool isIdle;
  final bool isSaving;
  final bool hasSaved;
  final bool validationError;
  final CounterItem counterWithErrors;

  CreateState({
    @required this.isIdle,
    this.isSaving = false,
    this.hasSaved = false,
    this.validationError = false,
    this.counterWithErrors,
  });

  factory CreateState.idle() => CreateState(isIdle: true);

  factory CreateState.saving() => CreateState(isIdle: false, isSaving: true);

  factory CreateState.saved() => CreateState(isIdle: false, hasSaved: true);

  factory CreateState.validationError(CounterItem item) => CreateState(
        isIdle: false,
        validationError: true,
        counterWithErrors: item,
      );
}

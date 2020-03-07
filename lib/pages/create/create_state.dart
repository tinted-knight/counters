import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:flutter/material.dart';

class CreateState extends BlocState {
  final bool isIdle;
  final bool isSaving;
  final bool hasSaved;

  CreateState({
    @required this.isIdle,
    this.isSaving = false,
    this.hasSaved = false,
  });

  factory CreateState.idle() => CreateState(isIdle: true);

  factory CreateState.saving() => CreateState(isIdle: false, isSaving: true);

  factory CreateState.saved() => CreateState(isIdle: false, hasSaved: true);
}

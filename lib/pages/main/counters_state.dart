import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

class CounterState extends BlocState {
  CounterState({
    this.isLoading = false,
    this.hasFailed = false,
    @required this.isLoaded,
    this.isUpdated = false,
    this.counters,
  });

  final bool isLoading;
  final bool hasFailed;
  final bool isLoaded;
  final bool isUpdated;
  final List<CounterItem> counters;

  factory CounterState.init() => CounterState(isLoaded: false);

  factory CounterState.loading() => CounterState(isLoading: true, isLoaded: false);

  factory CounterState.failed() => CounterState(hasFailed: true, isLoaded: true);

  factory CounterState.loaded(List<CounterItem> counters) => CounterState(
        isLoading: false,
        isLoaded: true,
        counters: counters,
      );

  factory CounterState.updated(List<CounterItem> counters) => CounterState(
        isLoading: false,
        isLoaded: true,
        isUpdated: true,
        counters: counters,
      );

  CounterState copyWith({int details}) => CounterState(
        isLoaded: this.isLoaded,
        isLoading: this.isLoading,
        hasFailed: this.hasFailed,
        counters: this.counters,
      );
}

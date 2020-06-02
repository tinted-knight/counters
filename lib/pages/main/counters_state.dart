import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';

class CounterState extends BlocState {
  CounterState();

  factory CounterState.loading() = CounterStateLoading;

  factory CounterState.failed() = CounterStateFailed;

  factory CounterState.empty() = CounterStateEmpty;

  factory CounterState.loaded(List<CounterItem> counters) => CounterStateLoaded(counters);
}

class CounterStateLoading extends CounterState {}

class CounterStateEmpty extends CounterState {}

class CounterStateFailed extends CounterState {}

class CounterStateLoaded extends CounterState {
  final List<CounterItem> counters;

  CounterStateLoaded(this.counters);
}

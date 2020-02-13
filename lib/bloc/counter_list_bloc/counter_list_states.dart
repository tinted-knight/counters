import 'package:counter/model/CounterModel.dart';

class CounterListStates {
  CounterListStates();

  factory CounterListStates.loading() = CounterListStateLoading;

  factory CounterListStates.empty() = CounterListStateEmpty;

  factory CounterListStates.values(List<CounterItem> values) = CounterListStateValues;

  factory CounterListStates.didUpdated(List<CounterItem> values) = CounterListStateDidUpdated;
}

class CounterListStateLoading extends CounterListStates {}

class CounterListStateEmpty extends CounterListStates {}

class CounterListStateDidUpdated extends CounterListStates {
  CounterListStateDidUpdated(this.values);

  final List<CounterItem> values;
}

class CounterListStateValues extends CounterListStates {
  CounterListStateValues(this.values);

  final List<CounterItem> values;
}
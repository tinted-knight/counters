import 'package:counter/model/HistoryModel.dart';

class HistoryState {
  HistoryState();

  factory HistoryState.loading() = HistoryStateLoading;

  factory HistoryState.error() = HistoryStateError;

  factory HistoryState.values(List<HistoryModel> value) = HistoryStateValues;
}

class HistoryStateLoading extends HistoryState {}

class HistoryStateError extends HistoryState {}

class HistoryStateValues extends HistoryState {
  HistoryStateValues(this.value);

  final List<HistoryModel> value;
}
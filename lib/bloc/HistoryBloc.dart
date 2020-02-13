import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:counter/model/storage/interface.dart';

class HistoryBloc extends BaseBlocWithStates<HistoryState> {
  HistoryBloc(this.storage) : super(initialState: HistoryState.loading());

  final ILocalStorage storage;

  void historyFor({CounterItem counter}) async {
    pushState(HistoryState.loading());
    final history = await storage.getHistoryFor(counter: counter);
    if (history.isNotEmpty) {
      pushState(HistoryState.values(history));
    } else {
      pushState(HistoryState.error());
    }
  }
}

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

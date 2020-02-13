import 'package:counter/bloc/BaseBloc.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';

import 'history_bloc_states.dart';

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

import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:counter/pages/details/details_event.dart';
import 'package:counter/pages/details/details_state.dart';

import 'details_controllers_mixin.dart';

class DetailsBloc extends BlocEventStateBase<DetailsEvent, DetailsState>
    with DetailsControllersMixin {
  DetailsBloc({this.repo}) : super(initialState: DetailsState.loading());
  final ILocalStorage repo;

  void load(CounterItem item) {
    fire(DetailsEvent.loaded(item));
    populateControllers(item);
  }

  void update() async {
    if (await _update() != null) fire(DetailsEvent.doneEditing());
  }

  void delete(CounterItem item) async {
    fire(DetailsEvent.deleting());
    if (await repo.delete(item)) {
      await repo.clearHistoryFor(item.id);
      // !achtung fake delay
      await Future.delayed(Duration(milliseconds: 500));
      fire(DetailsEvent.doneEditing());
    }
  }

  void stepUp() {
    final updated = fillFromControllers((lastState as DetailsStateLoaded).counter).stepUp();
    valueCtrl.text = updated.value.toString();
  }

  void stepDown() {
    final last = lastState as DetailsStateLoaded;
    final updated = fillFromControllers(last.counter).stepDown();
    valueCtrl.text = updated?.value?.toString() ?? last.counter.value.toString();
  }

  void resetValue() => valueCtrl.text = "0";

  Future<CounterItem> _update({int withColor}) async {
    final last = lastState as DetailsStateLoaded;
    final updatedItem = fillFromControllers(last.counter).copyWith(colorIndex: withColor);
    if (!isValid(updatedItem)) {
      fire(DetailsEvent.validationError(updatedItem));
      return null;
    }
    fire(DetailsEvent.saving());
    // !achtung fake
    await Future.delayed(Duration(milliseconds: 500));
    if (await repo.update(updatedItem)) {
      await repo.updateTodayHistory(
        updatedItem.id,
        updatedItem.value,
      );
      return updatedItem;
    }
    return null;
  }

  void applyColor(int color) async {
    final updated = await _update(withColor: color);
    if (updated != null) fire(DetailsEvent.colorUpdated(updated));
  }

  void backPressed() {
    if (lastState is DetailsStateLoaded) {
      final inState = (lastState as DetailsStateLoaded).counter;
      final current = fillFromControllers(inState);
      return fire(DetailsEvent.canceled(modified: !inState.equalTo(current)));
    } else {
      return fire(DetailsEvent.canceled(modified: false));
    }
  }

  @override
  Stream<DetailsState> eventHandler(DetailsEvent event, DetailsState currentState) async* {
    switch (event.type) {
      case DetailsEventType.loading:
        yield DetailsState.loading();
        break;
      case DetailsEventType.loaded:
        yield DetailsState.loaded(event.counter);
        break;
      case DetailsEventType.saving:
        yield DetailsState.saving(currentState.asLoaded.counter);
        break;
      case DetailsEventType.doneEditing:
        yield DetailsState.done(currentState.asLoaded.counter);
        break;
      case DetailsEventType.validationError:
        yield DetailsState.validationError(event.counterWithErrors);
        break;
      case DetailsEventType.canceled:
        yield DetailsState.canceled(
          currentState.asLoaded.counter,
          event.wasModified,
        );
        break;
      case DetailsEventType.deleting:
        yield DetailsState.deleting(currentState.asLoaded.counter);
        break;
      case DetailsEventType.colorUpdated:
        yield DetailsState.colorUpdated(event.counter);
        break;
    }
  }
}

extension AsLoaded on DetailsState {
  DetailsStateLoaded get asLoaded => this as DetailsStateLoaded;
}

import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:counter/pages/details/single_event.dart';
import 'package:counter/pages/details/single_state.dart';

import '../../bloc/helper_functions.dart';
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
    // todo fake
    await Future.delayed(Duration(seconds: 1));
    if (await repo.delete(item)) {
      fire(DetailsEvent.doneEditing());
    }
  }

  void stepUp() {
    final updated = fillFromControllers(lastState.counter).stepUp();
    valueCtrl.text = updated.value.toString();
  }

  void stepDown() {
    final updated = fillFromControllers(lastState.counter).stepDown();
    valueCtrl.text = updated?.value?.toString() ?? lastState.counter.value.toString();
  }

  void resetValue() => valueCtrl.text = "0";

  Future<CounterItem> _update({int withColor}) async {
    final updatedItem = fillFromControllers(lastState.counter).copyWith(colorIndex: withColor);
    if (!isValid(updatedItem)) {
      fire(DetailsEvent.validationError(updatedItem));
      return null;
    }
    fire(DetailsEvent.saving());
    // todo fake
    await Future.delayed(Duration(seconds: 1));
    if (await repo.update(updatedItem)) {
      return updatedItem;
    }
    return null;
  }

  void applyColor(int color) async {
    final updated = await _update(withColor: color);
    if (updated != null) fire(DetailsEvent.colorUpdated(updated));
  }

  void backPressed() {
    final current = fillFromControllers(lastState.counter);
    return fire(DetailsEvent.canceled(modified: !lastState.counter.equalTo(current)));
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
        yield currentState.copyWith(isSaving: true, hasCanceled: false);
        break;
      case DetailsEventType.doneEditing:
        yield DetailsState.done();
        break;
      case DetailsEventType.validationError:
        yield currentState.copyWith(
            validationError: true, counterWithErrors: event.counterWithErrors);
        break;
      case DetailsEventType.canceled:
        yield currentState.canceled(event.wasModified);
        break;
      case DetailsEventType.deleting:
        yield currentState.deleting();
        break;
      case DetailsEventType.colorUpdated:
        yield DetailsState.colorUpdated(event.counter);
        break;
    }
  }
}

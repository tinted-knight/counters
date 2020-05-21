import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/storage/interface.dart';
import 'package:counter/pages/create/create_controllers_mixin.dart';
import 'package:counter/pages/create/create_event.dart';
import 'package:counter/pages/create/create_state.dart';

class CreateBloc extends BlocEventStateBase<CreateEvent, CreateState> with CreateControllersMixin {
  CreateBloc(this.repo) : super(initialState: CreateState.idle());

  final ILocalStorage repo;

  void create() async {
    final newCounter = composeFromControllers();
    if (!isValid(newCounter)) {
      fire(CreateEvent.validationError(newCounter));
      return;
    }
    fire(CreateEvent.saving(newCounter));
    await repo.add(newCounter);
    // !achtung fake
    await Future.delayed(Duration(seconds: 1));
    fire(CreateEvent.saved());
  }

  @override
  Stream<CreateState> eventHandler(CreateEvent event, CreateState currentState) async* {
    switch (event.type) {
      case CreateEventType.idle:
        yield CreateState.idle();
        break;
      case CreateEventType.saving:
        yield CreateState.saving();
        break;
      case CreateEventType.saved:
        yield CreateState.saved();
        break;
      case CreateEventType.validationError:
        yield CreateState.validationError(event.counterWithErrors);
        break;
    }
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}

import 'package:counter/model/storage/interface.dart';

import '../model/CounterModel.dart';
import 'BaseBloc.dart';
import 'helper_functions.dart';

class CreateCounterBloc extends BaseBlocWithStates<CreateCounterState> {
  CreateCounterBloc(this.storage) : super() {
    pushState(CreateCounterState.idle);
  }

  final ILocalStorage storage;

  void create({String title, String step, String goal, String unit}) async {
    final newCounter = CounterItem(
      title: title,
      step: step.toInt(),
      goal: goal.toInt(),
      unit: unit,
    );
    pushState(CreateCounterState.inprogress);
    if (await storage.add(newCounter)) {
      pushState(CreateCounterState.success);
    } else {
      pushState(CreateCounterState.error);
    }
  }

  bool validateInput() {
    //todo
  }
}

enum CreateCounterState { idle, inprogress, success, error }

//class CreateCounterCommands {
//  CreateCounterCommands();
//
//  factory CreateCounterCommands.create(CounterItem value) = CreateCounterCreate;
//
//  factory CreateCounterCommands.cancel() = CreateCounterCancel;
//}
//
//class CreateCounterCancel extends CreateCounterCommands {}
//
//class CreateCounterCreate extends CreateCounterCommands {
//  CreateCounterCreate(this.value);
//
//  final CounterItem value;
//}

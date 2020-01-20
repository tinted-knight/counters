import 'package:counter/model/storage/interface.dart';

import '../model/CounterModel.dart';
import 'BaseBloc.dart';

class CreateCounterBloc extends BaseBlocWithStates<CreateCounterState> {
  CreateCounterBloc(this.storage) : super() {
    pushState(CreateCounterState.idle);
  }

  final ILocalStorage storage;

  void create({CounterItem counter}) async {
    pushState(CreateCounterState.inprogress);
    print("Lets create new counter");
    if (await storage.add(counter)) {
      print("Counter created!!!");
      pushState(CreateCounterState.success);
    } else {
      print("Creating counter failed");
      pushState(CreateCounterState.error);
    }
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

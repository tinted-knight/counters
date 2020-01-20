import 'dart:developer';

import 'package:counter/model/storage/interface.dart';

import '../model/CounterModel.dart';
import 'BaseBloc.dart';

class CreateCounterBloc extends BaseBlocWithStates<CreateCounterState> {
  CreateCounterBloc(this.storage) : super() {
    pushState(CreateCounterState.idle);
  }

  final ILocalStorage storage;

  CounterItem _item = CounterItem(
    title: "",
    value: 0,
    goal: 0,
    step: 0,
  );

  void save() async {
    pushState(CreateCounterState.inprogress);
    print("Lets save new counter");
    if (await storage.add(_item)) {
      print("Counter saved!!!");
      pushState(CreateCounterState.success);
    } else {
      print("Creating counter failed");
      pushState(CreateCounterState.error);
    }
  }

  void create({String title, String step, String goal, String unit}) async {
    final newCounter = CounterItem(
      title: title,
      step: _parseInt(step),
      goal: _parseInt(goal),
      unit: unit,
    );
    pushState(CreateCounterState.inprogress);
    print("Lets create new counter");
    if (await storage.add(newCounter)) {
      print("Counter created!!!");
      pushState(CreateCounterState.success);
    } else {
      print("Creating counter failed");
      pushState(CreateCounterState.error);
    }
  }

  // TODO: error handling
  _parseInt(String i) {
    print("parsing $i");
    return int.parse(i);
  }
}

extension CopyWith on CounterItem {
  CounterItem copyWith(
      {String title,
      int goal,
      int value,
      int step,
      String unit,
      int colorIndex}) {
    print("copyWith");
    return CounterItem(
      title: title ?? this.title,
      goal: goal ?? this.goal,
      value: value ?? this.value,
      step: step ?? this.step,
      unit: unit ?? this.unit,
      colorIndex: colorIndex ?? this.colorIndex,
    );
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

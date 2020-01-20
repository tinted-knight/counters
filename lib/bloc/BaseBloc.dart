import 'dart:async';

import 'package:flutter/material.dart';

abstract class BaseBloc<States> {
  void dispose();
}

abstract class BaseBlocWithStates<States> extends BaseBloc<States> {
  final streamController = StreamController<States>.broadcast();

  void pushState(States state) {
    if (!streamController.isClosed) {
      streamController.sink.add(state);
    } else {
      print('pushState (${States.toString()}), closed');
    }
  }

  Stream<States> get states => streamController.stream;

  void dispose() {
    streamController.close();
  }
}

abstract class BaseBlocWithCommands<State, Command>
    extends BaseBlocWithStates<State> {
  BaseBlocWithCommands() {
    commandsController.stream.listen(handleCommand);
  }

  final commandsController = StreamController<Command>.broadcast();

  StreamSink<Command> get commands => commandsController.sink;

  void handleCommand(Command command);

  @override
  void dispose() {
    super.dispose();
    commandsController.close();
  }
}

//TODO https://github.com/boeledi/Streams-Block-Reactive-Programming-in-Flutter/blob/master/lib/blocs/bloc_provider.dart
class BlocProvider<T extends BaseBloc> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BaseBloc>(BuildContext context) {
    BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BaseBloc>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

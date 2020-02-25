import 'package:flutter/material.dart';

import 'bloc_event_state.dart';

typedef Widget AsyncBlocStateBuilder<BlocState>(BuildContext context, BlocState state);
typedef StreamListener2<BlocState> = void Function(BlocState value);

class BlocStreamBuilder<BlocState> extends StatelessWidget {
  const BlocStreamBuilder({
    Key key,
    @required this.builder,
    @required this.bloc,
    this.stateListener,
  })  : assert(builder != null),
        assert(bloc != null),
        super(key: key);

  final BlocEventStateBase<BlocEvent, BlocState> bloc;
  final AsyncBlocStateBuilder<BlocState> builder;
  final StreamListener2<BlocState> stateListener;

  @override
  Widget build(BuildContext context) {
    return RedirectStreamBuilder2<BlocState>(
      stream: bloc.state,
      initialData: bloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) {
        return builder(context, snapshot.data);
      },
      navListener: stateListener,
    );
  }
}

class RedirectStreamBuilder2<BlocState> extends StreamBuilder<BlocState> {
  final StreamListener2<BlocState> navListener;

  const RedirectStreamBuilder2({
    Key key,
    BlocState initialData,
    Stream<BlocState> stream,
    @required this.navListener,
    @required AsyncWidgetBuilder<BlocState> builder,
  }) : super(key: key, initialData: initialData, stream: stream, builder: builder);

  @override
  AsyncSnapshot<BlocState> afterData(AsyncSnapshot<BlocState> current, BlocState data) {
    if (navListener != null) navListener(data);
    return super.afterData(current, data);
  }
}

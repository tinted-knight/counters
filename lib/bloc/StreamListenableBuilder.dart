import 'package:flutter/material.dart';

// https://stackoverflow.com/a/59347530/8460732
typedef StreamListener<T> = void Function(T value);

class StreamBuilderNav<T> extends StreamBuilder<T> {

  final StreamListener<T> listener;

  const StreamBuilderNav({
    Key key,
    T initialData,
    Stream<T> stream,
    @required this.listener,
    @required AsyncWidgetBuilder<T> builder,
  }) : super(key: key, initialData: initialData, stream: stream, builder: builder);

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    listener(data);
    return super.afterData(current, data);
  }
}
import 'package:counter/model/CounterModel.dart';

extension ToInt on String {
// TODO: error handling
  int toInt() {
    return int.parse(this);
  }
}

extension CopyWith on CounterItem {
  CounterItem copyWith({
    String title,
    int goal,
    int value,
    int step,
    String unit,
    int colorIndex,
  }) {
    return CounterItem(
      id: this.id,
      title: title ?? this.title,
      goal: goal ?? this.goal,
      value: value ?? this.value,
      step: step ?? this.step,
      unit: unit ?? this.unit,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  CounterItem stepUp() {
    print("stepUp: ${this.value} + ${this.step}");
    return this.copyWith(value: this.value + this.step);
  }

  CounterItem get flush => this.copyWith(value: 0);
}

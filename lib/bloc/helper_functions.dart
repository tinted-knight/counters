import 'package:counter/model/CounterModel.dart';

extension ToInt on String {
// TODO: error handling
  int toInt() {
    print("parsing $this");
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
}

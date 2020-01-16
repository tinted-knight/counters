class CounterItem {
  const CounterItem({
    this.title,
    this.value,
    this.isGoalReached,
    this.unit = "",
    this.colorIndex,
  });

  final String title;
  final int value;
  final bool isGoalReached;
  final String unit;
  final int colorIndex;
}

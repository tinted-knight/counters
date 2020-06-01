/// If no argument passed returns `milliseconds` `DateTime.now().fromMillisecondsSinceEpoch`
/// If [from] argument specified returns `milliseconds` only including YEAR, MOTH and DAY fields,
/// ignoring HOURS, MINUTES etc.
int datetime({int from}) {
  var now = DateTime.now();
  if (from != null) now = DateTime.fromMillisecondsSinceEpoch(from);

  return DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
}

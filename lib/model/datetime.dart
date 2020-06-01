int datetime({int from}) {
  var now = DateTime.now();
  if (from != null) now = DateTime.fromMillisecondsSinceEpoch(from);

  return DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
}

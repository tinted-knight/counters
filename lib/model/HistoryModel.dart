class HistoryModel {
  HistoryModel({this.id, this.counterId, this.date, this.value});

  final int id;
  final int counterId;
  final int date;
  final int value;

  Map<String, dynamic> toMap() => <String, dynamic>{
        colCounterId: counterId,
        colDate: date,
        colValue: value,
      };

  HistoryModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map["id"],
          counterId: map[colCounterId],
          date: map[colDate],
          value: map[colValue],
        );
}

const colCounterId = "counter_id";
const colDate = "date";
const colValue = "value";

extension DateString on HistoryModel {
  String get dateString => DateTime.fromMillisecondsSinceEpoch(date).toString();

  String get valueString => value.toString();
}

extension CopyWith on HistoryModel {
  HistoryModel copyWith({int value, int date}) => HistoryModel(
        id: this.id,
        counterId: this.counterId,
        date: date ?? this.date,
        value: value ?? this.value,
      );
}

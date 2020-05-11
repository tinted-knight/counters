import 'package:counter/model/HistoryModel.dart';

abstract class ILocalStorage<CounterItem> {
  Future<bool> add(CounterItem item);

  Future<List<CounterItem>> getAll();

  Future<bool> update(CounterItem item);

  Future<bool> delete(CounterItem item);

  Future<bool> updateHistory(CounterItem item, String timestamp);

  Future<bool> updateExistingHistoryItem(HistoryModel item);

  Future<List<HistoryModel>> getHistoryFor({CounterItem counter});

  Future<DateTime> getTime();

  Future<int> updateTime(int time);
}

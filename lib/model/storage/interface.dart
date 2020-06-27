import 'package:counter/model/HistoryModel.dart';

abstract class ILocalStorage<CounterItem> {
  Future<int> add(CounterItem item);

  Future<List<CounterItem>> getAll();

  Future<bool> update(CounterItem item);

  Future<bool> resetAll();

  Future<bool> delete(CounterItem item);

  Future<bool> clearHistoryFor(int id);

  Future<bool> insertHistory(int id, int value, int timestamp);

  Future<bool> updateTodayHistory(int id, int value);

  Future<bool> updateExistingHistoryItem(HistoryModel item);

  Future<List<HistoryModel>> getHistoryFor({CounterItem counter});

  Future<DateTime> getTime();

  Future<int> updateTime();
}

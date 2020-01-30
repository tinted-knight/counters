abstract class ILocalStorage<CounterItem> {
  Future<bool> add(CounterItem item);

  Future<List<CounterItem>> getAll();

  Future<bool> update(CounterItem item);

  Future<bool> delete(CounterItem item);

  Future<DateTime> getTime();

  Future<bool> updateTime(int time);
}
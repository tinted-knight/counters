import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:flutter/material.dart';

class ExistingItem {
  ExistingItem(this.item, this.value);

  final HistoryModel item;
  final String value;
}

class ChartState extends BlocState {
  ChartState({
    @required this.isLoading,
    this.isUpdating = false,
    this.hasUpdated = false,
    this.hasLoaded = false,
    this.isEmpty = false,
    this.hasCanceled = false,
    this.itemExists = false,
    this.missingValue,
    this.stat,
    this.filter = "7",
  });

  final bool isLoading;
  final bool isUpdating;
  final bool hasUpdated;
  final bool hasLoaded;
  final bool isEmpty;
  final bool hasCanceled;
  final bool itemExists;
  final ExistingItem missingValue;
  final List<HistoryModel> stat;
  final String filter;

  List<HistoryModel> get filtered {
    if (filter == "7") {
      return stat.sublist(0, stat.length > 7 ? 7 : stat.length);
//      return stat.where((element) => _isWeekDifference(element.date)).toList();
    }
    return stat;
  }

//  bool _isWeekDifference(int value) {
//    return DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(value)).inDays <= 7;
//  }

  factory ChartState.loading() => ChartState(isLoading: true);

  factory ChartState.empty() => ChartState(isLoading: false, isEmpty: true);

  factory ChartState.back() => ChartState(isLoading: false, hasCanceled: true);

  factory ChartState.filter(List<HistoryModel> items, String filter) => ChartState(
        isLoading: false,
        hasLoaded: true,
        stat: items,
        filter: filter,
      );

  factory ChartState.loaded(List<HistoryModel> items) => ChartState(
        isLoading: false,
        hasLoaded: true,
        stat: items,
      );

  factory ChartState.updated(List<HistoryModel> items) => ChartState(
        isLoading: false,
        hasLoaded: true,
        hasUpdated: true,
        stat: items,
      );

  factory ChartState.updating(List<HistoryModel> items) => ChartState(
        isLoading: false,
        isUpdating: true,
        stat: items,
      );

  factory ChartState.itemExists(List<HistoryModel> items, ExistingItem value) => ChartState(
        isLoading: false,
        hasLoaded: true,
        stat: items,
        missingValue: value,
        itemExists: true,
      );
}

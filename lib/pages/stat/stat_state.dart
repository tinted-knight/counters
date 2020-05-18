import 'package:counter/bloc/didierboelens/bloc_event_state.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:flutter/material.dart';

class ExistingItem {
  ExistingItem(this.item, this.value);

  final HistoryModel item;
  final String value;
}

class StatState extends BlocState {
  StatState({
    @required this.isLoading,
    this.isUpdating = false,
    this.hasLoaded = false,
    this.isEmpty = false,
    this.hasCanceled = false,
    this.itemExists = false,
    this.missingValue,
    this.stat,
  });

  final bool isLoading;
  final bool isUpdating;
  final bool hasLoaded;
  final bool isEmpty;
  final bool hasCanceled;
  final bool itemExists;
  final ExistingItem missingValue;
  final List<HistoryModel> stat;

  factory StatState.loading() => StatState(isLoading: true);

  factory StatState.empty() => StatState(isLoading: false, isEmpty: true);

  factory StatState.back() => StatState(isLoading: false, hasCanceled: true);

  factory StatState.loaded(List<HistoryModel> items) => StatState(
        isLoading: false,
        hasLoaded: true,
        stat: items,
      );

  factory StatState.updating(List<HistoryModel> items) => StatState(
        isLoading: false,
        isUpdating: true,
        stat: items,
      );

  factory StatState.itemExists(List<HistoryModel> items, ExistingItem value) => StatState(
        isLoading: false,
        hasLoaded: true,
        stat: items,
        missingValue: value,
        itemExists: true,
      );
}

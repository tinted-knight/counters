import 'package:counter/model/CounterModel.dart';
import 'package:counter/model/HistoryModel.dart';
import 'package:flutter/material.dart';

class StatListTile extends StatelessWidget {
  const StatListTile({
    Key key,
    this.entry,
    this.counter,
    @required this.onValueChanged,
    @required this.onEditTap,
  }) : super(key: key);

  final HistoryModel entry;
  final CounterItem counter;
  final Function(String) onValueChanged;
  final Function(HistoryModel) onEditTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      entry.valueString,
                      style: TextStyle(
                        color: entry.value > counter.goal
                            ? Colors.green
                            : entry.value == counter.goal ? Colors.blue : Colors.red,
                      ),
                    ),
                    Text(
                      entry.dateString,
                      style: TextStyle(color: Color(0xff717171)),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  final newValue = await onEditTap(entry);
                  onValueChanged(newValue);
                },
                color: Colors.black54,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                color: Colors.black54,
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}

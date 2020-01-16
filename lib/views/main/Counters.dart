import 'package:counter/model/CounterModel.dart';
import 'package:counter/views/details/screeen_details.dart';
import 'package:flutter/material.dart';

import 'counter_row/CounterRow.dart';

class Counters extends StatelessWidget {
  const Counters({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<CounterItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ScreenDetails(items[index]),
                ));
              },
              child: CounterRow(items[index]),
            ),
            _divider(),
          ],
        );
      },
    );
  }

  _divider() => Container(
        height: 1.0,
        margin: EdgeInsets.only(left: 32.0, right: 32.0),
        color: Colors.black12,
      );
}

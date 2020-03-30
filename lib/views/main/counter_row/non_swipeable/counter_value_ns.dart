import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:flutter/material.dart';

class CounterValueIncrement extends StatefulWidget {
  const CounterValueIncrement(this.item, {Key key, this.onTap}) : super(key: key);

  final CounterItem item;
  final Function onTap;

  @override
  _CounterValueIncrementState createState() => _CounterValueIncrementState();
}

class _CounterValueIncrementState extends State<CounterValueIncrement>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> greenAnimation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) controller.reverse();
    });

    greenAnimation = ColorTween(
      begin: ColorPalette.color(widget.item.colorIndex),
      end: Color.fromARGB(255, 0, 255, 0),
    ).animate(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        controller.forward();
      },
      child: _coloredValue(_valueNew()),
    );
  }

  Widget _coloredValue(Widget child) {
    return AnimatedBuilder(
      animation: greenAnimation,
      builder: (context, ccc) => Container(
        alignment: Alignment.center,
        width: 80.0,
        decoration: BoxDecoration(
          color: greenAnimation.value,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: ccc,
      ),
      child: child,
    );
  }

  Widget _valueNew() => Padding(
        padding: const EdgeInsets.only(right: 4.0, left: 4.0),
        child: Text(
          "+ ${widget.item.value.toString()}",
          style: kCounterValueStyle,
        ),
      );
}

// style
const kCounterValueStyle = TextStyle(
  color: Colors.white,
  fontFamily: "RobotoCondensed",
);
const kCounterUnitStyle = kCounterValueStyle;

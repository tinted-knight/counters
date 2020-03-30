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
      child: animatedValue(
        Column(
          children: <Widget>[
            valueNew,
            stepValue,
          ],
        ),
      ),
    );
  }

  Widget animatedValue(Widget value) {
    return AnimatedBuilder(
      animation: greenAnimation,
      builder: (context, child) => Container(
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
        child: child,
      ),
      child: value,
    );
  }

  Widget get valueNew => Padding(
        padding: const EdgeInsets.only(right: 4.0, left: 4.0),
        child: Text(
          widget.item.value.toString(),
          style: _kCounterValueStyle,
        ),
      );

  Widget get stepValue => Text(
        "+ ${widget.item.step}",
        style: _kCounterStepStyle,
      );
}

// style
const _kCounterValueStyle = TextStyle(
  color: Colors.white,
  fontFamily: "RobotoCondensed",
);
const _kCounterStepStyle = TextStyle(
  color: Color(0x77FFFFFF),
  fontFamily: "RobotoCondensed",
  fontSize: 10,
);

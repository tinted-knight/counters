import 'package:flutter/material.dart';

typedef OnSwiped = Function();

class ColoredSwipeable extends StatefulWidget {
  const ColoredSwipeable({
    Key key,
    @required this.child,
    @required this.onSwiped,
    @required this.onTap,
  }) : super(key: key);

  final Widget child;
  final OnSwiped onSwiped;
  final GestureTapCallback onTap;

  @override
  _ColoredSwipeableState createState() => _ColoredSwipeableState();
}

class _ColoredSwipeableState extends State<ColoredSwipeable>
    with SingleTickerProviderStateMixin {
  Color color;

  int _value = 255;

  final _distanceLimit = 50;
  final _velocityLimit = 500.0;

  AnimationController _colorController;
  Animation<Color> _currentAnimation;
  Animation<Color> _greenAnimation;
  Animation<Color> _redFlashAnimation;

  @override
  void initState() {
    super.initState();
    color = Color.fromARGB(50, 255, 255, 255);
    _colorController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _greenAnimation = ColorTween(
      begin: Color.fromARGB(50, 255, 255, 255),
      end: Color.fromARGB(50, 0, 255, 0),
    ).animate(_colorController);

    _redFlashAnimation = ColorTween(
      begin: Color.fromARGB(50, 255, 0, 0),
      end: Color.fromARGB(50, 255, 255, 255),
    ).animate(_colorController);

    _currentAnimation = _greenAnimation;
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  void _swipeNotCounted() {
    _colorController.reverse();
    _currentAnimation = _redFlashAnimation;
    _colorController.reset();
    _colorController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _resetToGreen();
    });
    _colorController.forward();
  }

  void _resetToGreen() {
    _colorController.reset();
    _currentAnimation = _greenAnimation;
  }

  void _swipeCounted() {
    widget.onSwiped();
    _colorController.reverse();
  }

  void _dragUpdate(DragUpdateDetails details) {
    final delta = (details.delta.dx * 2).floor();
    // decreasing red and green until 0 but not less
    final newValue = _value - delta > 0 ? _value -= delta : _value = 0;
    final target = -_value == 0 ? 0.9 : 1 - newValue / 255;
    _colorController.value = target;
    setState(() {
      _value = newValue;
    });
  }

  void _dragEnd(DragEndDetails details) {
    // if there is enough velocity in user's swipe
    // or swipe distance was long enough
    // then considering that swipe was successful
    if (details.velocity.pixelsPerSecond.dx >= _velocityLimit ||
        _value <= _distanceLimit) {
      _swipeCounted();
    } else {
      _swipeNotCounted();
    }
    setState(() {
      _value = 255;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onHorizontalDragUpdate: _dragUpdate,
      onHorizontalDragEnd: _dragEnd,
      child: AnimatedBuilder(
        animation: _currentAnimation,
        builder: (context, child) {
          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                    color: _currentAnimation.value,
                    padding: EdgeInsets.all(16.0)),
              ),
              widget.child,
            ],
          );
        },
      ),
    );
  }
}

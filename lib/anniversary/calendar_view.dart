import 'package:flutter/material.dart';
import 'package:with_u/anniversary/calendar_table.dart';

class CalendarView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const CalendarView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: CalendarTable(),
              ),
            ),
          );
      },
    );
  }
}

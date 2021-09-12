import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../resources/Theme.dart';
import 'package:flutter/material.dart';

class SloganView extends StatelessWidget {
  final String titleTxt;
  final AnimationController animationController;
  final Animation animation;

  const SloganView(
      {Key key, this.titleTxt: "", this.animationController, this.animation})
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
                  0.0, 30 * (1.0 - animation.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 40, bottom: 40),
                child: Column(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                      child: NeumorphicText(
                        titleTxt,
                        style: NeumorphicStyle(
                          depth: 4, //customize depth here
                          color:
                              AppTheme.deactivatedText, //customize color here
                        ),
                        textStyle: NeumorphicTextStyle(
                          fontSize: 24, //customize size here
                          // AND others usual text style properties (fontFamily, fontWeight, ...)
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                    child: Text(
                      DateTime.now().month.toString() + '月' +
                          DateTime.now().day.toString() + '日',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily:
                      AppTheme.fontName,
                      fontWeight:
                      FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 0.0,
                      color: AppTheme.grey
                          .withOpacity(0.8),
                    ),
                  ),
                  ),
                ]),
              ),
            ));
      },
    );
  }
}

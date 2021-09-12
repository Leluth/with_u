import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:with_u/resources/Theme.dart';
import 'package:flutter/material.dart';

class MessageListView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const MessageListView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 18),
            child: Column(
              children: <Widget>[
            new Transform(
                transform: new Matrix4.translationValues(
                    -30 * (1.0 - animation.value), 0.0, 0.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 16, bottom: 18),
                        child: Container(
                          child: NeumorphicButton(
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              surfaceIntensity: 0.1,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(48.0),
                                      bottomRight: Radius.circular(8.0),
                                      topRight: Radius.circular(68.0))),
                              color: AppTheme.background,
                              lightSource: LightSource.topLeft,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 18),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 16, right: 24),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4,
                                                  right: 4,
                                                  bottom: 16,
                                                  top: 16),
                                              child: Text(
                                                'Leluth',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: AppTheme.darkText),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.access_time,
                                                  color: AppTheme.grey
                                                      .withOpacity(0.5),
                                                  size: 16,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Text(
                                                    'Today 8:28 AM',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontName,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.0,
                                                      color: AppTheme.grey
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 3),
                                        child: Text(
                                          '早安',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 24,
                                            color: AppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ))),
            new Transform(
                transform: new Matrix4.translationValues(
                    30 * (1.0 - animation.value), 0.0, 0.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 16, bottom: 18),
                        child: Container(
                          child: NeumorphicButton(
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              surfaceIntensity: 0.1,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.only(
                                      topLeft: Radius.circular(48.0),
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(68.0),
                                      topRight: Radius.circular(8.0))),
                              color: AppTheme.background,
                              lightSource: LightSource.topLeft,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 18),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 16, right: 24),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4,
                                                  right: 4,
                                                  bottom: 16,
                                                  top: 16),
                                              child: Text(
                                                '我',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: AppTheme.darkText),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.access_time,
                                                  color: AppTheme.grey
                                                      .withOpacity(0.5),
                                                  size: 16,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Text(
                                                    'Today 20:28 PM',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontName,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: 0.0,
                                                      color: AppTheme.grey
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 3),
                                        child: Text(
                                          '晚安',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 24,
                                            color: AppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ))),
          ]),
        )
        );
      },
    );
  }
}

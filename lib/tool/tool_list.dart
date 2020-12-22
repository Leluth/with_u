import 'package:flutter/material.dart';
import 'package:with_u/tool/tips.dart';
import '../resources/theme.dart';

class ToolListView extends StatefulWidget {
  const ToolListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _ToolListViewState createState() => _ToolListViewState();
}

class _ToolListViewState extends State<ToolListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Map> ToolListData = <Map>[
    {
      'imagepath': 'lib/images/area1.png',
      'title': '绘梦',
      'description': '绘制我们的故事'
    },
    {
      'imagepath': 'lib/images/area2.png',
      'title': '连音',
      'description': '同一刻，倾听宇宙的声音'
    },
    {
      'imagepath': 'lib/images/area3.png',
      'title': '银幕',
      'description': '下午茶，电影，和你'
    },
    {
      'imagepath': 'lib/images/area1.png',
      'title': '星图',
      'description': '100个与你有关的成就'
    },
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Column(
                    children: List<Widget>.generate(
                      ToolListData.length,
                      (int index) {
                        final int count = ToolListData.length;
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController,
                            curve: Interval((1 / count) * index, 1.0,
                                curve: Curves.fastOutSlowIn),
                          ),
                        );
                        animationController.forward();
                        return AreaView(
                          imagepath: ToolListData[index]['imagepath'],
                          title: ToolListData[index]['title'],
                          description: ToolListData[index]['description'],
                          animation: animation,
                          animationController: animationController,
                        );
                      },
                    ),
                  ),
                ),
                TipView(
                    animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController,
                            curve: Interval((1 / 3) * 3, 1.0,
                                curve: Curves.fastOutSlowIn))),
                    animationController: animationController),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AreaView extends StatelessWidget {
  const AreaView({
    Key key,
    this.imagepath,
    this.title,
    this.description,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final String imagepath;
  final String title;
  final String description;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 0),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.grey.withOpacity(0.4),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                  splashColor:
                                      AppTheme.nearlyDarkBlue.withOpacity(0.2),
                                  onTap: () =>
                                      Scaffold.of(context).showSnackBar(_buildSnackBar()),
                                  child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(8.0)),
                                          child: SizedBox(
                                            height: 74,
                                            child: AspectRatio(
                                              aspectRatio: 1.5,
                                              child: Image.asset(imagepath),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 100,
                                                    right: 16,
                                                    top: 16,
                                                  ),
                                                  child: Text(
                                                    title,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontName,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 22,
                                                      letterSpacing: 0.0,
                                                      color: AppTheme
                                                          .nearlyDarkBlue,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 100,
                                                bottom: 12,
                                                top: 4,
                                                right: 16,
                                              ),
                                              child: Text(
                                                description,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontFamily: AppTheme.fontName,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                  color: AppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]))))),
                  // Positioned(
                  //   top: -16,
                  //   left: 0,
                  //   child: SizedBox(
                  //     width: 110,
                  //     height: 110,
                  //     child: Image.asset(imagepath),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSnackBar() {
    return SnackBar(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      content: Text('该区域仍在努力探索中'),
      duration: Duration(seconds: 2),
      //持续时间
      backgroundColor: AppTheme.nearlyDarkBlue.withOpacity(0.8),
      onVisible: () => print('onVisible'),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 62),
      action: SnackBarAction(
        label: '知道了',
        onPressed: (){},
      ),
    );
  }
}

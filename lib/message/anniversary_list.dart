import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:with_u/resources/theme.dart';

class AnniversaryListView extends StatefulWidget {
  const AnniversaryListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _AnniversaryListViewState createState() => _AnniversaryListViewState();
}

class _AnniversaryListViewState extends State<AnniversaryListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  var data = <Color>[
    Colors.yellow[400],
    Colors.yellow[700],
    Colors.yellow[800],
    Colors.yellow[900],
  ];

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
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
                child: Container(
                  height: 400,
                  // padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                  child: ScrollConfiguration(
                    behavior: NoScrollBehavior(),
                    child: ReorderableListView(
                      padding:
                      // const EdgeInsets.all(0),
                      const EdgeInsets.only(top: 16),
                      onReorder: _handleReorder,
                      children: data.map((color) => _buildItem(color)).toList(),
                    ),
                  ),
                )
        )
        );
      },
    );
  }

  void _handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    setState(() {
      final element = data.removeAt(oldIndex);
      data.insert(newIndex, element);
    });
  }

  Widget _buildItem(Color color) {
    // return
    return Container(
        key: ValueKey(color),
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child:
        Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          //   child: Neumorphic(
            key: ValueKey(color),
          //     style: NeumorphicStyle(
          //         shape: NeumorphicShape.flat,
          //         boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          //         depth: 8,
          //         intensity: 0.5,
          //         lightSource: LightSource.topLeft,
          //         color: Colors.transparent),
          child: Neumorphic(
            key: ValueKey(color),
            style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                depth: 10,
                intensity: 0.8,
                lightSource: LightSource.left,
                color: Colors.transparent
            ),
            child: SimpleFoldingCell.create(
              frontWidget: _buildFrontWidget(color),
              innerWidget: _buildInnerWidget(color),
              cellSize: Size(MediaQuery.of(context).size.width*0.9, 110),
              padding: const EdgeInsets.all(0),
              animationDuration: Duration(milliseconds: 300),
              onOpen: () => print('cell opened'),
              onClose: () => print('cell closed'),
            ),
          ),
          //   ),

          actions: <Widget>[
            IconSlideAction(
              caption: 'Archive',
              color: Colors.blue,
              icon: Icons.archive,
              onTap: () => Scaffold.of(context).showSnackBar(_buildSnackBar()),
            ),
            IconSlideAction(
              caption: 'Share',
              color: Colors.indigo,
              icon: Icons.share,
              onTap: () => Scaffold.of(context).showSnackBar(_buildSnackBar()),
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'More',
              color: Colors.black45,
              icon: Icons.more_horiz,
              onTap: () => Scaffold.of(context).showSnackBar(_buildSnackBar()),
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => Scaffold.of(context).showSnackBar(_buildSnackBar()),
            ),
          ],
        )
    );
  }

  Widget _buildFrontWidget(Color color) {
    return Builder(builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          final foldingCellState =
              context.findAncestorStateOfType<SimpleFoldingCellState>();
          foldingCellState?.toggleFold();
        },
        // child: Neumorphic(
        //   style: NeumorphicStyle(
        //       shape: NeumorphicShape.flat,
        //       boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        //       depth: 8,
        //       intensity: 1,
        //       lightSource: LightSource.topLeft,
        //       color: Colors.transparent
        //   ),
        child: Container(
          color: color,
          alignment: Alignment.center,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              colorString(color),
              style: TextStyle(color: Colors.white, shadows: [
                Shadow(
                    color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
              ]),
            ),
          ),
        ),
        // ),
      );
    });
  }

  Widget _buildInnerWidget(Color color) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          final foldingCellState =
              context.findAncestorStateOfType<SimpleFoldingCellState>();
          foldingCellState?.toggleFold();
        },
        child: Container(
          color: color,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "CARD TITLE",
            ),
          ),
        ),
      );
    });
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
        onPressed: () {},
      ),
    );
  }
}

class NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          axisDirection: axisDirection,
          color: AppTheme.nearlyDarkBlue,
        );
    }
    return null;
  }
}

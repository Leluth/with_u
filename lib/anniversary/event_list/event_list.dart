import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class EventListView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const EventListView({Key key, this.animationController, this.animation})
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
                    top: 24, bottom: 24, left: 28, right: 24),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width * 0.28,
                    child: new Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(15)),
                            child: new Image.asset(
                              'lib/images/placeholder.jpg',
                              fit: BoxFit.cover,
                            ));
                      },
                      autoplay: false,
                      autoplayDelay: 3000,
                      autoplayDisableOnInteraction: true,
                      loop: true,
                      onTap: (index) {
                        print(index);
                      },
                      itemCount: 4,
                      itemWidth: 300.0,
                      itemHeight: 250.0,
                      layout: SwiperLayout.STACK,
                      // layout: SwiperLayout.CUSTOM,
                      // customLayoutOption: new CustomLayoutOption(
                      //     startIndex: -1,
                      //     stateCount: 3
                      // ).addRotate([
                      //   -20.0/180,
                      //   0.0,
                      //   20.0/180
                      // ]).addTranslate([
                      //   new Offset(-270.0, -40.0),
                      //   new Offset(0.0, 0.0),
                      //   new Offset(270.0, -40.0)
                      // ]),
                    ))));
      },
    );
  }
}

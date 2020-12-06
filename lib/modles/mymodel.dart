import 'dart:math';
import 'package:flutter/cupertino.dart';

class MyModel extends ChangeNotifier{

  MyModel({
    this.crossFadeState=CrossFadeState.showFirst
  });

  var crossFadeState = CrossFadeState.showFirst;

  void changeCrossFadeState(){
    if (crossFadeState == CrossFadeState.showFirst) {
      crossFadeState = CrossFadeState.showSecond;
    } else {
      crossFadeState = CrossFadeState.showFirst;
    }
    notifyListeners();
  }

  void setCrossFadeState(){
    crossFadeState = CrossFadeState.showSecond;
    notifyListeners();
  }

}
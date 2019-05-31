import 'package:flutter/material.dart';
import 'package:weather_app/forecast/background/background_with_rings.dart';
import 'package:weather_app/forecast/background/rain.dart';
import 'package:weather_app/forecast/radial_list.dart';

class Forecast extends StatelessWidget {
  final RadialListViewModel radialList;
  final SlidingRadialListController slidingRadialListController;

  Forecast({
    @required this.radialList,
    @required this.slidingRadialListController,
  });

  Widget _tempretureText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 150.0, left: 10.0),
        child: Text(
          '25',
          style: TextStyle(color: Colors.white, fontSize: 80.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundWithRings(),
        _tempretureText(),
        SlidingRadialList(
           radialList: radialList,
           controller: slidingRadialListController, 
        ),
      Rain(),
      ],
    );
  }
}

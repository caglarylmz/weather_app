import 'package:flutter/material.dart';
import 'package:weather_app/widgets/spinner_text.dart';

class ForecastAppbar extends StatelessWidget {
  final Function onDrawerArrowTap;
  final String selectedDay;

  ForecastAppbar({this.onDrawerArrowTap, this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SpinnerText(
            text: selectedDay,
          ),
          Text(
            "İzmir",
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 35.0,
          ),
          onPressed: onDrawerArrowTap,
        )
      ],
    );
  }
}

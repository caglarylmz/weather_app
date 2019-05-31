import 'package:flutter/material.dart';
import 'package:weather_app/forecast/app_bar.dart';
import 'package:weather_app/forecast/foracast_list.dart';
import 'package:weather_app/forecast/forecast.dart';
import 'package:weather_app/forecast/radial_list.dart';
import 'package:weather_app/forecast/week_drawer.dart';
import 'package:weather_app/widgets/sliding_drawer.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin {
      //bir sayfada birden çok animation olduğundan SingleTickerProviderStateMixin kullanmadık
  OpenableController openableController;
  SlidingRadialListController slidingRadialListController;
  String selectDay= "Monday, August 26";

  @override
  void initState() {
    super.initState();
    openableController = new OpenableController(
      vsync: this,
      openDuration: const Duration(milliseconds: 250),
    )..addListener(() => setState(() {}));

    slidingRadialListController = SlidingRadialListController(
      itemCount: forecastRadialList.items.length,
      vsync: this,
    )
    ..open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
         Forecast(
           radialList: forecastRadialList,
           slidingRadialListController: slidingRadialListController,
         ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: ForecastAppbar(
              onDrawerArrowTap: openableController.open,
              selectedDay: selectDay,
            ),
          ),
          SlidingDrawer(
            openableController: openableController,
            drawer: WeekDrawer(
              onDaySelected: (String title) {
                setState(() {
                 selectDay=title.replaceAll("\n",", "); 
                });
                slidingRadialListController
                  .close()
                  .then((_)=>slidingRadialListController.open());
                openableController.close();
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BackgroundWithRings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        //background
        Image.asset(
          'assets/weather-bk_enlarged.png',
          fit: BoxFit.cover,
        ),
        //Etrafında hava durumu widgetlerinin bulunacağı çember
        ClipOval(
          child: Image.asset(
            'assets/weather-bk.png',
            fit: BoxFit.cover,
          ),
          clipper: CircleClipper(
            radius: 140.0,
            offset: Offset(40.0, 0.0),
          ),
        ),
        CustomPaint(
          painter: WhiteCircleCoutoutPointer(
              centerOffset: const Offset(40.0, 0.0),
              circles: [
                Circle(radius: 140.0, alpha: 0x10),
                Circle(radius: 140.0 + 15.0, alpha: 0x28),
                Circle(radius: 140.0 + 30.0, alpha: 0x38),
                Circle(radius: 140.0 + 75.0, alpha: 0x50),
              ]),
        )
      ],
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {
  final double radius;
  final Offset offset;

  CircleClipper({this.radius, this.offset = const Offset(0.0, 0.0)});

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(0.0, size.height / 2) + offset,
      radius: radius,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return null;
  }
}

class WhiteCircleCoutoutPointer extends CustomPainter {
  final Color overlayColor = const Color(0xFFAA88AA);

  final List<Circle> circles;
  final Offset centerOffset;
  final Paint whitePaint;
  final Paint borderPaint;

  WhiteCircleCoutoutPointer(
      {this.circles = const [], this.centerOffset = const Offset(0.0, 0.0)})
      : whitePaint = new Paint(),
        borderPaint = new Paint() {
    borderPaint
      ..color = const Color(0x10FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 1; i < circles.length; ++i) {
      _maskCircle(canvas, size, circles[i - 1].radius);
      whitePaint.color = overlayColor.withAlpha(circles[i - 1].alpha);

      //fill Circle
      canvas.drawCircle(Offset(0.0, size.height / 2) + centerOffset,
          circles[i].radius, whitePaint);
      //Draw circle bevel
      canvas.drawCircle(Offset(0.0, size.height / 2) + centerOffset,
          circles[i - 1].radius, borderPaint);
    }
    //Mask the area off the final circle
    _maskCircle(canvas, size, circles.last.radius);

    //Draw an overlay that fills the rest of screen
    whitePaint.color = overlayColor.withAlpha(circles.last.alpha);
    canvas.drawRect(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height), whitePaint);
    //draw the bevel for final sicrle
    canvas.drawCircle(Offset(0.0, size.height / 2) + centerOffset,
        circles.last.radius, borderPaint);
  }

  _maskCircle(Canvas canvas, Size size, double radius) {
    Path clippedCircle = Path();
    clippedCircle.fillType = PathFillType.evenOdd;
    clippedCircle.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    clippedCircle.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height / 2) + centerOffset, radius: radius));
    canvas.clipPath(clippedCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}

class Circle {
  final double radius;
  final int alpha;

  Circle({this.radius, this.alpha = 0xFF});
}

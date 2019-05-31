import 'package:flutter/material.dart';

class SpinnerText extends StatefulWidget {
  final String text;

  const SpinnerText({
    this.text = ""
  });

  _SpinnerTextState createState() => _SpinnerTextState();
}

class _SpinnerTextState extends State<SpinnerText>
    with SingleTickerProviderStateMixin {
  String topText = "";
  String bottomText = "";
  AnimationController _spinTextAnimationController;
  Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    bottomText = widget.text;

    _spinTextAnimationController = new AnimationController(
        duration: const Duration(milliseconds: 750), vsync: this)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            bottomText = topText;
            topText = "";
            _spinTextAnimationController.value = 0.0;
          });
        }
      });

    _spinAnimation = CurvedAnimation(
        parent: _spinTextAnimationController, curve: Curves.elasticInOut);
  }

  @override
  void dispose() {
    super.dispose();
    _spinTextAnimationController.dispose();
  }

  @override
  void didUpdateWidget(SpinnerText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      //Need to spin new value
      topText = widget.text;
      _spinTextAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: RectClipper(),
      child: Stack(
        children: <Widget>[
          FractionalTranslation(
            translation: Offset(0.0, _spinAnimation.value - 1.0),
            child: Text(
              topText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.0, _spinAnimation.value),
            child: Text(
              bottomText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height+2);
  }
  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
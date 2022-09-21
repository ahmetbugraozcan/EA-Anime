import 'package:flutter/material.dart';

class BounceWithoutHover extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Duration duration;
  // This will get the data from the pages
  // Makes sure child won't be passed as null
  BounceWithoutHover(
      {required this.child, required this.duration, required this.onPressed});

  @override
  BounceWithoutHoverState createState() => BounceWithoutHoverState();
}

class BounceWithoutHoverState extends State<BounceWithoutHover>
    with SingleTickerProviderStateMixin {
  late double _scale;

  // This controller is responsible for the animation
  late AnimationController _animate;

  //Getting the VoidCallack onPressed passed by the user
  VoidCallback get onPressed => widget.onPressed;

  // This is a user defined duration, which will be responsible for
  // what kind of bounce he/she wants
  Duration get userDuration => widget.duration;

  @override
  void initState() {
    //defining the controller
    _animate = AnimationController(
        vsync: this,
        duration: const Duration(
            milliseconds: 200), //This is an inital controller duration
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      }); // Can do something in the listener, but not required
    super.initState();
  }

  @override
  void dispose() {
    // To dispose the contorller when not required
    _animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animate.value;
    return GestureDetector(
        onTap: _onTap,
        child: Transform.scale(
          scale: _scale,
          child: widget.child,
        ));
  }

  //This is where the animation works out for us
  // Both the animation happens in the same method,
  // but in a duration of time, and our callback is called here as well
  void _onTap() {
    //Firing the animation right away
    _animate.forward();

    //Now reversing the animation after the user defined duration
    Future.delayed(userDuration, () {
      _animate.reverse();

      //Calling the callback
      onPressed();
    });
  }
}

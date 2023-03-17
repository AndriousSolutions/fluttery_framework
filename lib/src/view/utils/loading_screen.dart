/// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  21 Jun 2018
///

import 'package:flutter/material.dart'
    show
        AnimatedBuilder,
        Animation,
        AnimationController,
        AnimationStatus,
        AppBar,
        BuildContext,
        Center,
        CircularProgressIndicator,
        CurvedAnimation,
        Curves,
        Interval,
        Key,
        MaterialApp,
        Scaffold,
        SingleTickerProviderStateMixin,
        State,
        StatefulWidget,
        Text,
        Widget;

///
/// This is just a basic `Scaffold` with a centered `CircularProgressIndicator`
/// class right in the middle of the screen.
///
/// It's copied from the `flutter_gallery` example project in flutter/flutter
///
class LoadingScreen extends StatefulWidget {
  /// Basic `Scaffold` with a centered `CircularProgressIndicator`
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this)
      ..forward();
    _animation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.9, curve: Curves.fastOutSlowIn),
        reverseCurve: Curves.fastOutSlowIn)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        } else if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Loading...')),
            body: AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return const Center(child: CircularProgressIndicator());
                })));
  }
}

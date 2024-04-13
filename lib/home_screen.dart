import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';


// TO DO: Replace with your App Group ID
const String appGroupId = 'group.widgetget';
const String iOSWidgetName = 'HomeWidgets';
const String androidWidgetName = 'HomeWidget';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void updateHeadline() {
  HomeWidget.saveWidgetData<String>('headline_title', "Updated text after 5 min");
 
  HomeWidget.updateWidget(
    iOSName: iOSWidgetName,
    androidName: androidWidgetName,
  );
}

class _MyHomePageState extends State<MyHomePage> {
   late Timer _timer;

  @override
  void initState() {
    super.initState();
    HomeWidget.setAppGroupId(appGroupId);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      updateHeadline();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Widget Home'),
            centerTitle: false,
            titleTextStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        body: ListView(
          children: const [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("The widget is ready for use"),
              ],
            )
          ],
        )
    );
  }
}

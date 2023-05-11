import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:fluttertest/edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Second Page',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: _SettingPage(),
    );
  }
}

class _SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("第二页")],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<StatefulWidget> {
  double offsetX = 0.0;
  double offsetY = 0.0;
  double scale = 1.0;
  double preScale = 1.0;
  bool isScaling = false;
  Matrix4 matrix4 = Matrix4.identity();
  Matrix4 componentMatrix4 = Matrix4.identity();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("第一页"),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              Flexible(
                child: GestureDetector(
                  onScaleStart: (details) => {
                    preScale = 1.0,
                    if (details.pointerCount > 1) {isScaling = true}
                    /*  else
                          {isScaling = false}*/
                  },
                  onScaleUpdate: (details) => {
                    setState(() {
                      if (!isScaling) {
                        offsetX += details.focalPointDelta.dx;
                        offsetY += details.focalPointDelta.dy;
                        Matrix4 matrix = Matrix4.identity()
                          ..translate(offsetX, offsetY)
                          ..scale(scale) /*..rotateZ(rotation)*/;

                        print('deltax: ${details.focalPointDelta.dx}');
                        matrix4 = matrix;
                      } else {
                        double deltaScale = details.scale / preScale;
                        scale *= deltaScale;
                        preScale = details.scale;
                        Matrix4 matrix = Matrix4.copy(matrix4)
                          ..scale(deltaScale);
                        matrix4 = matrix;
                      }
                    })
                  },
                  onScaleEnd: (details) => {
                    if (details.pointerCount == 0) {isScaling = false}
                  },
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.amber,
                      alignment: Alignment.topLeft,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Transform(
                            transform: matrix4,
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  color: Colors.lightBlue,
                                  alignment: Alignment.topLeft,
                                )),
                          ),
                          Transform(
                            transform: matrix4,
                            child: EditContainer(
                              matrix4: componentMatrix4,
                              moveCallback: (ScaleUpdateDetails details) {
                                Matrix4 matrix = Matrix4.copy(componentMatrix4)
                                  ..translate(details.focalPointDelta.dx,
                                      details.focalPointDelta.dy);
                                setState(() {
                                  componentMatrix4 = matrix;
                                });
                              },
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.topLeft,
                                    color: Colors.white,
                                    child: const Image(
                                        image: AssetImage('assets/robot.png'))),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      child: const Text("顺时针旋转"),
                      onPressed: () => {
                        super.setState(() {
                          double angle = 90 * math.pi / 180;
                          Matrix4 matrix = Matrix4.copy(componentMatrix4)
                            ..translate(50 / 2, 50 / 2)
                            ..rotateZ(angle)
                            ..translate(-50 / 2, -50 / 2);
                          componentMatrix4 = matrix;
                        })
                      }),
                  ElevatedButton(onPressed: () => {

                  }, child: Text("添加"))
                ],
              )
            ],
          )),
    );
  }
}

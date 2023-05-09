import 'package:flutter/material.dart';
import 'dart:math' as math;

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
  double rotation = 0.0;
  bool isScaling = false;
  Matrix4 matrix4 = Matrix4.identity();

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
                  fit: FlexFit.tight,
                  child: Transform.scale(
                      scale: scale,
                      child: Transform.rotate(
                        angle: rotation,
                        child: Transform.translate(
                            offset: Offset(offsetX, offsetY),
                            child: GestureDetector(
                              onScaleStart: (details) => {
                                preScale = 1.0,
                                if (details.pointerCount > 1)
                                  {isScaling = true}
                                else
                                  {isScaling = false}
                              },
                              onScaleUpdate: (details) => {
                                setState(() {
                                  if (!isScaling) {
                                    matrix4.translate(
                                        details.focalPointDelta.dx,
                                        details.focalPointDelta.dy
                                    );
                                    List<double> array = [0.0, 0.0, 0.0];
                                    matrix4.applyToVector3Array(array);
                                    offsetX += details.focalPointDelta.dx;
                                    offsetY += details.focalPointDelta.dy;
                                  } else {
                                    scale *= details.scale / preScale;
                                    preScale = details.scale;
                                    Matrix4 matrix = Matrix4.identity();
                                    matrix
                                      ..translate(offsetX, offsetY)
                                      ..scale(scale)
                                      ..rotateZ(rotation);
                                    List<double> array = [0.0, 0.0, 0.0];
                                    matrix.applyToVector3Array(array);
                                    offsetX = array[0];
                                    offsetY = array[1];
                                  }
                                })
                              },
                              onScaleEnd: (details) => {
                                if (details.pointerCount == 0)
                                  {
                                    //isScaling = false
                                  }
                              },
                              child: Container(
                                color: Colors.lightBlue,
                                child: const Image(
                                    image: AssetImage('assets/robot.png')),
                              ),
                            )),
                      ))),
              ElevatedButton(
                  child: const Text("顺时针旋转"),
                  onPressed: () => {
                        super.setState(() {
                          rotation += 90 * math.pi / 180;
                          Matrix4 matrix = Matrix4.identity()
                            ..rotateZ(rotation)
                            ..translate(offsetX, offsetY)
                          ;
                          List<double> array = [0.0, 0.0, 0.0];
                          matrix.applyToVector3Array(array);
                          setState(() {
                            offsetX = array[0];
                            offsetY = array[1];
                          });
                        })
                      })
            ],
          )),
    );
  }
}

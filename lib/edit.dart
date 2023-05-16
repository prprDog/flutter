import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:fluttertest/bean.dart';

class EditContainer extends StatefulWidget {
  final Widget child;
  final Matrix4 matrix4;
  final GestureScaleUpdateCallback? moveCallback;

  @override
  State<StatefulWidget> createState() {
    return _EditContainerState();
  }

  const EditContainer(
      {super.key,
      required this.child,
      required this.matrix4,
      required this.moveCallback});
}

class _EditContainerState extends State<EditContainer> {
  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: widget.matrix4,
        child: GestureDetector(
          onScaleUpdate: widget.moveCallback,
          child: widget.child,
        ));
  }
}

class ImageComponent extends StatefulWidget {
  final Matrix4 matrix4;
  ComponentData data;

  ImageComponent({super.key, required this.matrix4, required this.data});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageComponent();
  }
}

class _ImageComponent extends State<ImageComponent> {
  Matrix4 componentMatrix4 = Matrix4.identity();

  @override
  void initState() {
    super.initState();
    double angle = widget.data.rotation * math.pi / 180;
    componentMatrix4
      ..translate(widget.data.x, widget.data.y)
      ..translate(widget.data.width / 2, widget.data.height / 2)
      ..rotateZ(angle)
      ..translate(-widget.data.width / 2, -widget.data.height / 2);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform(
        transform: widget.matrix4,
        child: Transform.translate(
            offset: Offset(widget.data.x, widget.data.y),
            child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onScaleUpdate: (details) => {
                    setState(() {
                      Matrix4 matrix = Matrix4.copy(componentMatrix4)
                        ..translate(details.focalPointDelta.dx,
                            details.focalPointDelta.dy);
                      componentMatrix4 = matrix;
                      widget.data.x += details.focalPointDelta.dx;
                      widget.data.y += details.focalPointDelta.dy;
                    })
                  },
                  child: Transform.rotate(
                    angle: widget.data.rotation * math.pi / 180,
                    child: Container(
                        width: widget.data.width,
                        height: widget.data.height,
                        alignment: Alignment.topLeft,
                        color: Colors.white,
                        child:
                            const Image(image: AssetImage('assets/robot.png'))),
                  ),
                ))));
  }
}

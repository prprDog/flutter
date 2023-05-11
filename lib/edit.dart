import 'package:flutter/cupertino.dart';

class EditContainer extends StatefulWidget {
  final Widget child;
  final Matrix4 matrix4;
  final GestureScaleUpdateCallback? moveCallback;

  @override
  State<StatefulWidget> createState() {
    return _EditContainerState();
  }

  const EditContainer({super.key, required this.child, required this.matrix4, required this.moveCallback});
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
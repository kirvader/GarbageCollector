import 'package:flutter/material.dart';

class ImageLoadMethodChoiceButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double cornerRadius;
  final double height;

  const ImageLoadMethodChoiceButton(
      {Key? key,
      this.height = 300,
      required this.child,
      this.cornerRadius = 15.0,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(
              3.0
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.white)
              )
          )
        ),
        child: SizedBox(
            height: height,
            child: Center(child: child)));
  }
}

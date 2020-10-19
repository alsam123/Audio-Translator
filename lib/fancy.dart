import 'package:flutter/material.dart';
class FancyButton extends StatelessWidget {
  FancyButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return 
      RawMaterialButton(
      fillColor: Color(0xff064a7a),
      splashColor: Color(0xff064a7a),
      child:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const<Widget>[
            
            Text(
              "Translate",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
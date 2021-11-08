import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class nakopitDialog extends StatelessWidget{
  TextStyle styleText = TextStyle(fontSize: 20,color: Colors.white60,);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[800],
      content: Container(
        height: 60,
          child: Text('Новая запись сохранена',style: styleText,)),
      actions: <Widget>[
        FlatButton(onPressed: () {
          Navigator.of(context).pop();
        },
            child: Text('OK',style: styleText,)),

      ],
    );
  }

}
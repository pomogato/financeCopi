import 'package:finance_copi/main.dart';
import 'package:finance_copi/tabs/nakopit.dart';
import 'package:finance_copi/tabs/setings.dart';
import 'package:flutter/material.dart';

class menuKey extends StatefulWidget{


  @override
  menuKeyState createState() => menuKeyState();
}

class menuKeyState extends State<menuKey> {
  int _StatePage = 0;


   var kTabs = <Widget>[
    MyHomePage(),
    Nakopit(),
    Setings(),
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              top: 3,
              child:
              kTabs[_StatePage ],

            ),
            Positioned(
              bottom: 10,
              left: 15,
              right: 15,
              child: Container(
                height: 65,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius:  BorderRadius.circular(15),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                        flex: 2,
                        child: TextButton(onPressed: (){
                          setState(() {
                            _StatePage = 0;
                          });
                        },
                            child: Center(
                          child: Text('Цели',style:
                          TextStyle(fontSize: 18,color: Colors.white60,fontWeight: FontWeight.bold)),
                        ))),
                    Expanded(
                        flex: 1,
                      child: IconButton(onPressed: (){
                        setState(() {
                          _StatePage = 1;

                        });
                      },
                         icon: Icon(Icons.add_circle_outline,size: 55,color: Colors.grey[400],),
                      ),),
                    Expanded(
                      flex: 2,
                      child: TextButton(onPressed: (){
                        setState(() {
                          _StatePage = 2;

                        });
                      },
                      child: Center(
                        child: Text('Настройки',style:
                        TextStyle(fontSize: 18,color: Colors.white60,fontWeight: FontWeight.bold)),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );

  }
}

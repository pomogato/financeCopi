import 'package:flutter/material.dart';

class Setings extends StatefulWidget{
  @override
  SetingsState createState() => SetingsState();
}

class SetingsState extends State<Setings> {
  TextStyle _style = TextStyle(fontSize: 20,color: Colors.white60,);
  @override
  Widget build(BuildContext context) {
    final _widthOsnov = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.max,

            children: [
              Expanded(
                  child:
                  Text("НАСТРОЙКИ",style: TextStyle(fontSize: 14,color: Colors.white60,fontWeight: FontWeight.bold))),

              //  TextButton(
              //       onPressed:
              //         () => Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => Nakopit(),
              //          )).then((_) {
              //        refresh();
              //      }),
              //     child:
              //      Text("Добавить +",style: TextStyle(fontSize: 14,color: Colors.white60,fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        elevation: 10,

      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30,15, 30, 0),
              child: Container(

                height: 50,
                width: _widthOsnov,
                child: Center(child: Text('Настройки пользователя',style: _style,)),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius:  BorderRadius.all(Radius.circular(20),),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30,15, 30, 0),
              child: Container(

                height: 50,
                width: _widthOsnov,
                child: Center(child: Text('Обратная связь',style: _style,)),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius:  BorderRadius.all(Radius.circular(20),),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30,15, 30, 0),
              child: Container(

                height: 50,
                width: _widthOsnov,
                child: Center(child: Text('О приложении',style: _style,)),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius:  BorderRadius.all(Radius.circular(20),),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

}
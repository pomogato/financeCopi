import 'package:finance_copi/tabs/cardGoal.dart';
import 'package:finance_copi/tabs/goal_delete.dart';
import 'package:finance_copi/tabs/menu_key.dart';
import 'package:finance_copi/tabs/nakopit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/todo-item.dart';
import 'services/db.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await DB.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white10,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,


      home: menuKey(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List<TodoItem> tasks = [];
  TextStyle _style = TextStyle(fontSize: 16,color: Colors.white60,);

  List<Widget> get _items => tasks.map((item) => format(item)).toList();


  Widget format(TodoItem item) {
    double _value_Progress = item.money/item.sum;
    int _procent = (_value_Progress *100).toInt();
    final _widthOsnov = MediaQuery.of(context).size.width;

    return Dismissible(
      key: Key(item.id.toString()),
      child: Padding(
          padding: EdgeInsets.fromLTRB(15,15, 15, 0),
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardGoal(item: item),
                )).then((_) {
              refresh();
            }),
            child: Container(

              height: 100,
              width: _widthOsnov,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: _widthOsnov*_value_Progress,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[800],
                      borderRadius:  BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),),
                  ),
                  Padding(
                  padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                            children:
                            [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  value: _value_Progress,
                                  backgroundColor: Colors.grey,
                                  strokeWidth: 6,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                               // child: Text('23%',style:  TextStyle(fontSize: 23,color: Colors.white,),),//Icon(Icons.attach_money,size: 40,color: Colors.white60,),
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius:  BorderRadius.circular(35),),
                              ),
                              Text('${_procent}%',style:  TextStyle(fontSize: 18,color: Colors.white,),),
                            ]
                        ),

                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('ЦЕЛЬ: ', style: _style),
                                Text(item.task, style: _style),
                                SizedBox(width: 30,),
                                Text('${item.money.toString()}/', style: _style),
                                Text(item.sum.toString(), style: _style),
                                Text(' ${item.currency}', style: _style),
                              ],
                            ),
                            Row(
                              children: [
                                Text('${item.DateNowDay}/${item.DateNowMonth}/${item.DateNowYear} -',style: TextStyle(fontSize: 14),),
                                Text(' ${item.DateLastDay}/${item.DateLastMonth}/${item.DateLastYear}',style: TextStyle(fontSize: 14),),
                              ],
                            ),

                          ],
                        ),




                      ]
                  ),
                ),

                ],
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius:  BorderRadius.circular(10),),
            ),
          )
      ),

      onDismissed: (DismissDirection direction) =>{ //_delete(item),
       },
      confirmDismiss: (DismissDirection direction) async {
        final result =  await showDialog(
            context: context,
            builder: (_) => GoalDelete());
        if(result==true){
          _delete(item);
        }
        return result;
      },
      background: Container(
        padding: EdgeInsets.only(left: 20),
        child: Align(child: Icon(Icons.delete,color:  Colors.grey,size: 70,),alignment: Alignment.centerLeft,),
      ),

    );
  }



  void _delete(TodoItem item) async {

    DB.delete(TodoItem.table, item);
    refresh();
  }





  @override
  void initState() {


    super.initState();
    refresh();
  }

  void refresh() async {
    print('refresh');
    List<Map<String, dynamic>> _results = await DB.query(TodoItem.table);
    tasks = _results.map((item) => TodoItem.fromMap(item)).toList();
    setState(() { });
  }


  @override
  Widget build(BuildContext context) {

    print('главная load');

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
                  Text("ЦЕЛИ",style: TextStyle(fontSize: 14,color: Colors.white60,fontWeight: FontWeight.bold))),
              
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
      body:
          Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView(
                shrinkWrap: true,
                children: _items ),
          ),






      );
  }
}

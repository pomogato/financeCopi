
import 'package:finance_copi/models/todo-item.dart';
import 'package:finance_copi/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CardGoal extends StatefulWidget{
  final TodoItem item;

  const CardGoal( {
    Key key, this.item,
  }) : super(key: key);


  @override
  _CardGoalState createState() => _CardGoalState();
  
}

class _CardGoalState extends State<CardGoal> {
  TextStyle styleText = TextStyle(fontSize: 16,color: Colors.white60,);
  TextEditingController _section_id = new TextEditingController();
  int _money_dob =0;
  int _moneyNakopleno =0;
  double value_Progress;
  int procent;
  int _summa;
  int _money_ost;





  void _add() async {


    TodoItem item = TodoItem(
        id:widget.item.id,
        task: widget.item.task,
        sum: widget.item.sum,
        currency: widget.item.currency,
        money: _moneyNakopleno,
        DateNowYear: widget.item.DateNowYear,
        DateNowMonth: widget.item.DateNowMonth,
        DateNowDay: widget.item.DateNowDay,
        DateLastYear: widget.item.DateLastYear,
        DateLastMonth: widget.item.DateLastMonth,
        DateLastDay: widget.item.DateLastDay,
        platesh: widget.item.platesh
    );

   await DB.update(TodoItem.table, item);

  }


  @override
  void initState() {
    super.initState();
  }

  void _progress(){
    setState(() {
      value_Progress = _moneyNakopleno/_summa;
      procent = (value_Progress *100).toInt();
    });



  }

  @override
  Widget build(BuildContext context) {
      print('add goal');
      String _goal = widget.item.task;
      String _currency = widget.item.currency;
      _summa = widget.item.sum;
      if(_money_dob==0){
      _moneyNakopleno = widget.item.money;
      _money_ost=_summa-_moneyNakopleno;
      }
      _progress();



    return Scaffold(
      backgroundColor: Colors.white30,
      appBar:  AppBar(
        backgroundColor: Colors.white10,
        automaticallyImplyLeading: false,
        title:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              TextButton(
                  onPressed: () => {
                   Navigator.pop(context, false) ,
                  },
                  child:
                  Text("Назад",style:styleText)),

              TextButton(
                onPressed: () => {
                  _add(),
                  Navigator.pop(context, false) ,
                },
                child:
                Text("Изменить",style: styleText),
              ),
            ],
          ),
        ),
        elevation: 30,

      ),
    body:  Column(
      children: [
        SizedBox(height: 25,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 15,),
            Stack(
                alignment: Alignment.center,
                children:
                [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      value: value_Progress,
                      backgroundColor: Colors.grey,
                      strokeWidth: 6,
                    ),
                  ),
                  Container(
                    width: 74,
                    height: 74,
                    // child: Text('23%',style:  TextStyle(fontSize: 23,color: Colors.white,),),//Icon(Icons.attach_money,size: 40,color: Colors.white60,),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius:  BorderRadius.circular(35),),
                  ),
                  Text('$procent%',style:  TextStyle(fontSize: 24,color: Colors.white,),),
                ]
            ),
            SizedBox(width: 15,),
            Column(
             // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Цель: ",style: styleText),
                    Text(_goal,style:styleText),
                    SizedBox(width: 15,),
                    Text("$_summa",style:styleText),
                    SizedBox(width: 5,),
                    Text("$_currency",style:styleText),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Container(
                    width:190,
                    height: 1,color: Colors.white10,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Накоплено",style:styleText),
                        Text("$_moneyNakopleno",style:styleText),
                      ],
                    ),
                    //SizedBox(width: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                      child: Container(
                        width:1,
                        height: 30,color: Colors.white10,
                      ),
                    ),
                    Column(
                      children: [
                        Text("Осталось",style:styleText),
                        Text("$_money_ost",style:styleText),

                      ],
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(width: 15,),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Container(
            width: double.infinity,
            height: 1,color: Colors.white10,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 40,
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),

              child: TextField(
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(fontSize: 16,color: Colors.white),
                cursorHeight: 16,
                controller: _section_id,
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: '${widget.item.platesh}',
                  hintStyle:TextStyle(fontSize: 16,color: Colors.white,),
                  border:  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),

              ),
            ),
            TextButton(
              onPressed:  ()=> setState(() {
                _money_dob = int.tryParse(_section_id.text);
                if(_money_dob<=_money_ost){
                    _moneyNakopleno = _moneyNakopleno + _money_dob;
                    _money_ost = _summa - _moneyNakopleno;
                  }
                else{
                  _moneyNakopleno=_summa;
                  _money_ost=0;
                }
                  _add();
                  _progress();

              }),


              child: Text("Пополнить",style:
              TextStyle(fontSize: 16,color: Colors.white60)),
            )
          ],
        ),

      ],
    ),

    );

  }
}
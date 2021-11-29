import 'package:finance_copi/models/todo-item.dart';
import 'package:finance_copi/services/db.dart';
import 'package:finance_copi/tabs/date_dialog.dart';
import 'package:finance_copi/tabs/menu_key.dart';
import 'package:finance_copi/tabs/nakopit_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Nakopit extends StatefulWidget{


  @override
  _NakopitState createState() => _NakopitState();
}

class _NakopitState extends State<Nakopit> {
  TextStyle styleText = TextStyle(fontSize: 16,color: Colors.white60,);
  int StateMeny = 1;
  int StatePage = 1;
  List ListOption = ["Null","Накопить","Выплатить денег","Сократить расходы","Увеличить доходы"];
  final  galocka = [Icons.arrow_drop_up_outlined,Icons.arrow_drop_down_outlined];
  List listItem = ['USD', 'EUR', 'BYN', 'RUB'];
  String usd = 'USD';

  String _task = 'Новая цель';
  String _currency = 'USD';
  int _sum = 0;
  int _money = 0;
  TextEditingController _section_id = new TextEditingController();
  TextEditingController _section_id1 = new TextEditingController();
  DateTime DateNow = DateTime.now();
  DateTime DateLast = DateTime.now();
  int _months = 0;
  int _platesh = 0;

  void plateshSet() async{
    if(int.tryParse(_section_id.text)!=null)
    {
      _sum = int.parse(_section_id.text);
    }
    else _sum = 0;
    print(_sum);
    if(int.tryParse(_section_id1.text)!=null)
    {
      _money = int.parse(_section_id1.text);
    }
    else _money = 0;
    print(_money);


    if(DateLast.difference(DateNow).inDays <= 30 && DateLast.difference(DateNow).inDays > 0)
      _months = 1;
    else if(DateLast.difference(DateNow).inDays > 30){
      _months = DateLast
          .difference(DateNow)
         .inDays ~/ 30;
    }
    else {
      _months = 0;
      setState(() {
        DateLast = DateNow;
      });
    }
    print(_months);

    if(_months!=0 && _sum>_money) {
      setState(() {
          _platesh =
             ( _sum - _money) ~/ _months;
      });
    }
    else if(_months ==0 && _money ==0){
      setState(() {

        _platesh = _sum;
      });
    }
     else if(_sum ==0 || _money>_sum || _money ==0){
      setState(() {

        _platesh = 0;
      });
    }


  }

  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }




  void _save() async {
    await showDialog(
        context: context,
        builder: (_) => nakopitDialog());

     // Navigator.of(context).pop();
    TodoItem item = TodoItem(
          task: _task,
          sum: _sum,
          currency: _currency,
          money: _money,
          DateNowYear: DateNow.year.toInt(),
          DateNowMonth: DateNow.month.toInt(),
          DateNowDay: DateNow.day.toInt(),
          DateLastYear: DateLast.year.toInt(),
          DateLastMonth: DateLast.month.toInt(),
          DateLastDay: DateLast.day.toInt(),
          platesh: _platesh,
          itemId: 111111,
          historyTrue: 0);


      await DB.insert(TodoItem.table, item);

  }






  @override
  Widget build(BuildContext context) {
    print('добавить load');

    final kTabs = <Widget>[
       Center(child:
       Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [

            SizedBox(
              height: 5,
            ),
            razdelitel(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    onPressed: () =>{ setState(() => StatePage=1),
                      setState(() => StateMeny=1)},
                    child:
                    Text(ListOption[1],style: TextStyle(fontSize: 14,color: Colors.white60,)),
                  ),
                ],
              ),
            ),
            razdelitel(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    onPressed: () => {setState(() => StatePage=2),
                      setState(() => StateMeny=1)},
                    child:
                    Text(ListOption[2],style: TextStyle(fontSize: 14,color: Colors.white60,)),
                  ),
                ],
              ),
            ),
            razdelitel(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    onPressed: () => {setState(() => StatePage=3),
                      setState(() => StateMeny=1)},
                    child:
                    Text(ListOption[3],style: TextStyle(fontSize: 14,color: Colors.white60,)),
                  ),
                ],
              ),
            ),
            razdelitel(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    onPressed: () => {setState(() => StatePage=4),
                      setState(() => StateMeny=1)},
                    child:
                    Text(ListOption[4],style: TextStyle(fontSize: 14,color: Colors.white60,)),
                  ),
                ],
              ),
            ),
            razdelitel(),

          ],),
      ),),
      SingleChildScrollView(


                 child: Column(

                   children: [


                     Container(
                       height: 80,
                       padding: EdgeInsets.all(20),

                       child: TextField(
                         textAlignVertical: TextAlignVertical.bottom,
                         style: TextStyle(fontSize: 16,color: Colors.white),
                         cursorHeight: 16,
                         textInputAction: TextInputAction.next,
                         onChanged: (value) { _task = value; },
                         decoration: InputDecoration(
                           fillColor: Colors.grey,
                           filled: true,
                           hintText: 'Описание',
                           hintStyle:TextStyle(fontSize: 16,color: Colors.white,),
                           icon: Icon(Icons.add_circle_outline,size: 40,color: Colors.grey,),

                           border:  OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(20.0)),
                           ),
                         ),

                       ),
                     ),
                     razdelitel(),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                         Text("Цель",style: styleText),
                           Container(
                             child: Row(
                               children: [
                                 Container(
                                   width: 240,
                                   child: TextField(
                                     style: styleText,
                                     cursorHeight: 16,
                                     keyboardType: TextInputType.number,
                                     textInputAction: TextInputAction.next,
                                     textAlignVertical: TextAlignVertical.top,
                                     textAlign:TextAlign.right,
                                     controller: _section_id,
                                     onChanged: (_) {
                                       plateshSet();
                                     },
                                     decoration: InputDecoration(
                                       hintText: '0,00',
                                       hintStyle:styleText,
                                       border:  InputBorder.none,
                                     ),

                                   ),
                                 ),
                                 Icon(Icons.arrow_forward_ios,size: 14,color: Colors.white60,),
                               ],
                             ),
                           ),

                       ],),

                     ),
                     razdelitel(),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text("Первоначальная сумма",style: styleText),
                           Expanded(
                             flex: 1,
                             child: SizedBox(height: 30,width: 1,),
                           ),
                       Row(
                               children: [
                                 Container(
                                   width: 40,
                                   child: TextField(
                                     style: styleText,
                                     cursorHeight: 16,
                                     keyboardType: TextInputType.number,
                                     textAlignVertical: TextAlignVertical.top,
                                     textAlign:TextAlign.right,
                                     controller: _section_id1,
                                     onChanged: (_) {
                                       plateshSet();
                                     },
                                     decoration: InputDecoration(
                                       hintText: '0,00',
                                       hintStyle:styleText,
                                       border:  InputBorder.none,
                                     ),

                                   ),
                                 ),
                                 Icon(Icons.arrow_forward_ios,size: 14,color: Colors.white60,),
                               ],
                             ),


                         ],),

                     ),
                     razdelitel(),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text("C:",style: styleText),
                           TextButton(
                             onPressed: () async {
                               final result =  await showDialog(
                                   context: context,
                                   builder: (_) => dateDialog(res: DateNow,));
                               if(result != false){

                                 setState(() {
                                   DateNow = result;

                                 });
                               }
                               plateshSet();
                             },
                               child:
                               Text("${formatDateTime(DateNow)}",style: styleText)),

                           Text("- ПО:",style: styleText),
                           TextButton(
                               onPressed: () async {
                                 final result =  await showDialog(
                                     context: context,
                                     builder: (_) => dateDialog(res: DateLast,));
                                 if(result != false){
                                   setState(() {
                                     DateLast = result;
                                   });}
                                 plateshSet();

                               },
                               child:
                               Text("${formatDateTime(DateLast)}",style: styleText)),



                         ],),

                     ),
                     razdelitel(),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text("Валюта",style: styleText),
                           Container(
                               height: 30,
                               child: spisok()),
                         ],),

                     ),
                     razdelitel(),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Минимальная сумма ",style: styleText),
                               Text("ежемесячного платежа: ",style: styleText),

                             ],
                           ),
                           Expanded(child: SizedBox()),
                           Text('$_platesh ',style: styleText,),
                           Text(_currency,style: styleText),

                         ],),

                     ),
                     razdelitel(),

                   ],
                 ),

           ),

      const Center(child:
      Text("Выплатить денег",style: TextStyle(fontSize: 16,color: Colors.white60,fontWeight: FontWeight.bold)),),
      const Center(child:
      Text("Сократить расходы",style: TextStyle(fontSize: 16,color: Colors.white60,fontWeight: FontWeight.bold)),),
      const Center(child:
      Text("Увеличить доходы",style: TextStyle(fontSize: 16,color: Colors.white60,fontWeight: FontWeight.bold)),),


    ];


    return Scaffold(
      backgroundColor: Colors.transparent,
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
              Container(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () =>{ setState(() => StateMeny==0 ? StateMeny=1 : StateMeny=0)},
                        child:
                        Text(ListOption[StatePage],style: TextStyle(fontSize: 14,color: Colors.white60,fontWeight: FontWeight.bold))),
                    Icon(galocka[StateMeny],size: 20,color: Colors.white60,),
                  ],
                ),
              ),
              TextButton(
              onPressed: () =>{
                if(int.tryParse(_section_id.text)!=null)
                  _save(),},

              child:
              Text("Сохранить",style: TextStyle(fontSize: 14,color: Colors.white60,fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        elevation: 30,

      ),
      body: kTabs[StateMeny!=0 ? StatePage : StateMeny],

    );


  }
  Widget spisok(){
    return DropdownButton(
      dropdownColor: Colors.grey,
      value: usd,
      onChanged: (newValue){
        setState(() {
          usd = newValue;
          _currency = usd;

        });
      },
      items: listItem.map((valueItem){
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem),
        );
      } ).toList(),
      icon: const Icon(Icons.arrow_forward_ios,size: 16,color: Colors.white60,),

      elevation: 30,
      style: styleText,
      underline: Container(
        height: 1,
        color: Colors.transparent,
      ),


    );
  }

  Widget razdelitel(){
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
        child: Container(width: double.infinity,height: 1,color: Colors.white10,));

  }
}


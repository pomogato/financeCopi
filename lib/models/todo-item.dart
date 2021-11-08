
import 'package:finance_copi/models/model.dart';

class TodoItem extends Model {

  static String table = 'todo_items';

  int id;
  String task;
  int sum;
  String currency;
  int money;
  int DateNowYear;
  int DateNowMonth;
  int DateNowDay;
  int DateLastYear;
  int DateLastMonth;
  int DateLastDay;
  int platesh;



  TodoItem({ this.id, this.task, this.sum, this.currency,
    this.money,this.DateNowYear,this.DateNowMonth,this.DateNowDay,
  this.DateLastYear,this.DateLastMonth,this.DateLastDay,this.platesh});

  Map<String, dynamic> toMap() {

    Map< String, dynamic> map = {
      'task': task,
      'sum': sum,
      'currency': currency,
      'money' : money,
      'DateNowYear' : DateNowYear,
      'DateNowMonth' : DateNowMonth,
      'DateNowDay' : DateNowDay,
      'DateLastYear' : DateLastYear,
      'DateLastMonth' : DateLastMonth,
      'DateLastDay' : DateLastDay,
      'platesh' : platesh
    };

    if (id != null) { map['id'] = id; }
    return map;
  }

  static TodoItem fromMap(Map<String, dynamic> map) {

    return TodoItem(
        id: map['id'],
        task: map['task'],
        sum: map['sum'],
        currency: map['currency'],
        money: map['money'],
        DateNowYear: map['DateNowYear'],
        DateNowMonth: map['DateNowMonth'],
        DateNowDay: map['DateNowDay'],
        DateLastYear: map['DateLastYear'],
        DateLastMonth: map['DateLastMonth'],
        DateLastDay: map['DateLastDay'],
        platesh: map['platesh']
    );
  }
}
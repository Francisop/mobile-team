import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logic extends ChangeNotifier{

  List _intervals = ['15','30','45','60']; 
  int _notifyCounter = 1;


 getInterval() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.getString('interval');
}

void signin(String name) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name);
}

void setInterval(String value) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('interval', value);
}

void setNotifyCounter() async{
  int notifyCounter = 1;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var notifs = prefs.getInt('notifyCounter');
  notifs = notifs + notifyCounter;
  await prefs.setInt('notifyCounter', notifs);

}
getNotifyCounter() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var notifs = prefs.getInt('notifyCounter');
  if (notifs == null) {
    notifs = 0;
  }
  return notifs;

}

}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic.dart';
import 'dashboard.dart';

class Login extends StatefulWidget {
  Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  checkname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name');
    if (name != null) {
      print('$name');
      Navigator.of(context).push(
        MaterialPageRoute(
          settings: RouteSettings(name: "/Page1"),
          builder: (context) => DashBoard(),
        ),
      );
      Navigator.of(context).popUntil(ModalRoute.withName("/Page1"));
    }
  }

  @override
  void initState() {
    super.initState();
    checkname();
  }

  String _name;

  final _formKey = GlobalKey<FormState>();

  var _dropdownValue = '15';
  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<Logic>(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/login.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: Stack(children: <Widget>[
                  Positioned(
                    child: Builder(builder: (BuildContext context) {
                      return Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'choose an interval in minutes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 23),
                                    DropdownButton(
                                      items: <String>['15', '30', '45', '60']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (String value) {
                                        setState(() {
                                          _dropdownValue = value;
                                        });
                                      },
                                      value: _dropdownValue,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'name cannot be empty';
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _name = value;
                                    });
                                  },  
                                  decoration: InputDecoration(
                                      hintText: 'Your name please',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              MaterialButton(
                                minWidth: 380,
                                height: 50,
                                color: Colors.purple[900],
                                onPressed: () {
                                  logic.signin(_name);
                                  print('$_name');
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    print('valid');
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        settings: RouteSettings(name: "/Page1"),
                                        builder: (context) => DashBoard(),
                                      ),
                                    );
                                    Navigator.of(context).popUntil(
                                        ModalRoute.withName("/Page1"));
                                  }
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ));
                    }),
                  ),
                ]),
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic.dart';

class DashBoard extends StatelessWidget {
  DashBoard({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<Logic>(context);
    var notif = logic.getNotifyCounter();
    print('$notif'.toString());
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          // Adobe XD layer: 'Home' (shape)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/home.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Text('$notif'),
          ),
        ],
      ),
    );
  }
}

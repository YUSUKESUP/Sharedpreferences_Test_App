import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {

  var _switch1 = false;
  var _switch2 = false;
  var _switch3 = false;

  _saveBool(String key, bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  _restoreValues() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      _switch1 = prefs.getBool('bool1') ?? false;
      _switch2 = prefs.getBool('bool2') ?? false;
      _switch3 = prefs.getBool('bool3') ?? false;
    });
  }

  @override
  void initState() {
    _restoreValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pref Test'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SwitchListTile(
                value: _switch1,
                title: Text('Setting 1'),
                onChanged: (bool value) {
                  setState(() {
                    _switch1 = value;
                    _saveBool('bool1', value);
                  });
                },
              ),
              SwitchListTile(
                value: _switch2,
                title: Text('Setting 2'),
                onChanged: (bool value) {
                  setState(() {
                    _switch2 = value;
                    _saveBool('bool2', value);
                  });
                },
              ),
              SwitchListTile(
                value: _switch3,
                title: Text('Setting 3'),
                onChanged: (bool value) {
                  setState(() {
                    _switch3 = value;
                    _saveBool('bool3', value);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
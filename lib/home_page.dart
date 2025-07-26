import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  int count = 0;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "";
    count = prefs.getInt("count") ?? 0;
    count++;
    prefs.setInt("count", count);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    if(count%3==0 && count%5==0){
      bgColor = Colors.orange;
    } else if(count%5==0){
      bgColor = Colors.blue;
    } else if(count%3==0){
      bgColor = Colors.green;
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: Text('Home')),
      body: Stack(
        children: [
          Center(
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 300,
                fontWeight: FontWeight.bold,
                color: Colors.black26,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                name.isNotEmpty ? Text("Welcome, $name") : Container(),
                TextField(controller: nameController),
                ElevatedButton(
                  onPressed: () async {
                    String userName = nameController.text;

                    ///store data
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("name", userName);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

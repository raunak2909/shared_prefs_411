import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";

  TextEditingController nameController = TextEditingController();

  @override
  void initState(){
    super.initState();
    getName();
  }

  void getName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            name.isNotEmpty ? Text("Welcome, $name") : Container(),
            TextField(
              controller: nameController,
            ),
            ElevatedButton(onPressed: () async {
              String userName = nameController.text;
              ///store data
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("name", userName);
            }, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}

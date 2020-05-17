import 'package:flutter/material.dart';

class AddAssetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add Asset',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 30.0,
                ),
              ),
              TextField(
                autofocus: true, //keyboard enabled, focusted
                textAlign: TextAlign.center,
                onChanged: (newText) {},
              ),
              FlatButton(
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.lightBlueAccent,
                onPressed: () {
                  //add task
//                  Provider.of<TaskData>(context, listen: false)
//                      .addTask(newTaskTitle);
                  Navigator.pop(context);
                }, //onPressed is not added -> disabled
              ),
            ],
          ),
        ),
      ),
    );
  }
}

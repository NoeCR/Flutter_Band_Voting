import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/band.model.dart';

class HomePage extends StatefulWidget {
  final String pageName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '1', name: 'AC/DC', votes: 15),
    Band(id: '1', name: 'Heroes del silencio', votes: 3),
    Band(id: '1', name: 'Bon Jovi', votes: 5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        // TODO: Remove band
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete band', style: TextStyle(color: Colors.white)),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name'),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
              ),
            ],
            content: TextField(
              controller: textController,
            ),
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New band name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String bandName) {
    if (bandName.length > 1) {
      this.bands.add(
            Band(id: DateTime.now().toString(), name: bandName, votes: 0),
          );

      setState(() {});
    }

    Navigator.pop(context);
  }
}

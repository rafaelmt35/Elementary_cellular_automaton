import 'dart:core';

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const ElementaryCellAutomata());
}

class ElementaryCellAutomata extends StatefulWidget {
  const ElementaryCellAutomata({super.key});

  @override
  State<ElementaryCellAutomata> createState() => _ElementaryCellAutomataState();
}

class _ElementaryCellAutomataState extends State<ElementaryCellAutomata> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: myApp());
  }
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  Timer? timer;
  Duration duration = Duration(seconds: 5);
  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {});
    });
  }
  
  List selectedIndex = [];
  List<List<int>> value = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];
  TextEditingController controllerRules = TextEditingController();
  Color colColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade900,
          title: const Text('Elementary Cellular Automaton'),
        ),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'RULES',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextField(
                    controller: controllerRules,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Rules',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 14.0),
                Container(
                    height: 440.0,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(border: Border.all(width: 1.0)),
                    child: _buildCells()),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          getGeneration();
                        },
                        child: Container(
                          height: 60.0,
                          width: 140.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.green),
                          child: const Center(
                              child: Text(
                            'START/GO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          )),
                        )),
                    InkWell(
                        onTap: () {
                          clear();
                        },
                        child: Container(
                          height: 60.0,
                          width: 140.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.green),
                          child: const Center(
                              child: Text(
                            'CLEAR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          )),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCells() {
    int gridStateLength = value.length;
    return Column(children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridStateLength,
            ),
            itemBuilder: _buildGridItems,
            itemCount: gridStateLength * gridStateLength,
          ),
        ),
      ),
    ]);
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = value.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    int temp = value[x][y];
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedIndex.contains(index)) {
            selectedIndex.remove(index);
            x = (index / gridStateLength).floor();
            y = (index % gridStateLength);
            value[x][y] = 0;
          } else {
            selectedIndex.add(index);
            x = (index / gridStateLength).floor();
            y = (index % gridStateLength);
            value[x][y] = 1;
          }
        });
      },
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              color: value[x][y] == 1 ? Colors.green : Colors.white,
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Center(
            child: Text(temp.toString()),
          ),
        ),
      ),
    );
  }


  //FUNCTION GET NEXT GENERATION
  void getGeneration() {
    //CHANGE RULES TO BINARY

    var num = int.parse(controllerRules.text);
    var binarynum = num.toRadixString(2);
    int difference = 8 - binarynum.length;
    for (int i = 0; i < difference; i++) {
      binarynum = "0$binarynum";
    }
    print(binarynum);

    //SAVING RULES
    Map<String, int> dictionaryRules = {
      "111": int.parse(binarynum[0]),
      "110": int.parse(binarynum[1]),
      "101": int.parse(binarynum[2]),
      "100": int.parse(binarynum[3]),
      "011": int.parse(binarynum[4]),
      "010": int.parse(binarynum[5]),
      "001": int.parse(binarynum[6]),
      "000": int.parse(binarynum[7]),
    };

    List oldIndex = [];
    var neighborleft, neighborright, temp, oldRes;
    var oldkey;

    List newIndex = [];
    int initial = 0;

    //OLD VALUE ASSIGN
    for (int i = 0; i < value.length; i++) {
      oldIndex.add(value[initial][i]);
    }

    //ITERATION 1 - 14 (14x)
    for (int iteration = 1; iteration < oldIndex.length; iteration++) {
      //INDEXCELL ARRAY PLACE
      for (int indexcell = 0; indexcell < oldIndex.length; indexcell++) {
        //INDEXCELL FIRST
        if (indexcell == 0) {
          setState(() {
            neighborleft = oldIndex[oldIndex.length - 1];
            neighborright = oldIndex[1];
            temp = oldIndex[0];
            oldRes = neighborleft.toString() +
                temp.toString() +
                neighborright.toString();
          });
          for (var key in dictionaryRules.keys) {
            if (oldRes == key) {
              setState(() {
                oldkey = key;
                value[iteration][indexcell] =
                    int.parse(dictionaryRules[oldkey].toString());
              });
            }
          }

          //INDEXCELL LAST
        } else if (indexcell == oldIndex.length - 1) {
          setState(() {
            neighborleft = oldIndex[oldIndex.length - 1];
            neighborright = oldIndex[0];
            temp = oldIndex[oldIndex.last];
            oldRes = neighborleft.toString() +
                temp.toString() +
                neighborright.toString();
          });

          for (var key in dictionaryRules.keys) {
            if (oldRes == key) {
              setState(() {
                oldkey = key;
                value[iteration][indexcell] =
                    int.parse(dictionaryRules[oldkey].toString());
              });
            }
          }
        } else {
          setState(() {
            neighborleft = oldIndex[indexcell - 1];
            neighborright = oldIndex[indexcell + 1];
            temp = oldIndex[indexcell];
            oldRes = neighborleft.toString() +
                temp.toString() +
                neighborright.toString();
          });

          //ASSIGN NEW VALUE FOR NEXT ROW
          for (var key in dictionaryRules.keys) {
            if (oldRes == key) {
              setState(() {
                oldkey = key;
                value[iteration][indexcell] =
                    int.parse(dictionaryRules[oldkey].toString());
              });
            }
          }
        }
      }

      oldIndex.clear();

      //ASSIGN NEW INDEXING ROW , CLEAR OLD VALUE  CHANGE WITH NEW VALUE
      for (int b = 0; b < value.length; b++) {
        newIndex.add(value[iteration][b]);
        setState(() {
          oldIndex = newIndex;
        });
      }
    }
  }

  //CLEAR CELLS
  void clear() {
    for (int i = 0; i < value.length; i++) {
      for (int j = 0; j < value.length; j++) {
        setState(() {
          value[i][j] = 0;
        });
      }
    }
  }
}

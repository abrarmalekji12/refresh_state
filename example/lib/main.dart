import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:refresh_state/refresh_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum AppState { red, green, blue }

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    refresh<int>('abc', (state) => state, data: (oldData) => oldData! + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Refresher<int>(
                id: 'abc',
                initialData: 0,
                initialState: AppState.blue,
                listener: (state, data) {
                  if (kDebugMode) {
                    print('listening $state $data');
                  }
                },
                builder: (context, state, data) {
                  return Center(
                      child: CircleAvatar(
                    radius: 30,
                    backgroundColor: state == AppState.red
                        ? Colors.red
                        : state == AppState.green
                            ? Colors.green
                            : Colors.blue,
                    child: Text(
                      '$data',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ));
                },
              ),
              Refresher<int>(
                id: 'abc',
                initialData: 0,
                initialState: AppState.blue,
                builder: (context, state, data) {
                  return Center(
                      child: CircleAvatar(
                    radius: 30,
                    backgroundColor: state == AppState.red
                        ? Colors.red
                        : state == AppState.green
                            ? Colors.green
                            : Colors.blue,
                    child: Text(
                      '$data',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ));
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                refresh('abc', (state) {
                  if (state == AppState.blue) {
                    return AppState.red;
                  } else if (state == AppState.red) {
                    return AppState.green;
                  } else {
                    return AppState.blue;
                  }
                });
              },
              child: const Text(
                'Switch Colors',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

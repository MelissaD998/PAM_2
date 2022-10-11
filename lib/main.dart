import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {   //dont change
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const AgeCalculator(),
    );
  }
}

class AgeCalculator extends StatefulWidget {    //dinamic widgets
  const AgeCalculator({super.key});

  @override
  State<AgeCalculator> createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  late int day, month, year;
  String result = 'Tap on the button to select your date of birth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
            child: Text(result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 150, 150, 150),
            child: ElevatedButton(
              child: const Text('Pick your birthday'),
              onPressed: () {
                calculateAge();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future calculateAge() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    day = int.parse(DateFormat("dd").format(dateTime!));
    month = int.parse(DateFormat("MM").format(dateTime!));
    year = int.parse(DateFormat("yy").format(dateTime!));

    int currentDay = int.parse(DateFormat("dd").format(DateTime.now()));
    int currentMonth = int.parse(DateFormat("MM").format(DateTime.now()));
    int currentYear = int.parse(DateFormat("yy").format(DateTime.now()));
      //data validation
    if (day <= currentDay) {
      day = currentDay - day;
    } else {
      day = 31 - day;
    }
    if (month <= currentMonth) {
      month = currentMonth - month;
    } else {
      month = 12 - month;
      year -= 1;
    }
    year = currentYear > year ? currentYear - year : year - currentYear;

    setState(() { //setarea starii
      result = "You are $year years $month months and $day days old";
    });
  }
}

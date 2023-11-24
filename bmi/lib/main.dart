import 'package:bmi/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allow only portrait orientation
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var itController = TextEditingController();

  var result = "";

  var bgcolor = Color.fromARGB(255, 99, 15, 115);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "BMI Calculator",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 62, 18, 92),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: bgcolor,
          ),
          child: Center(
            child: Container(
              width: 320,
              height: 450,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 45, 3, 53),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 31),
                  TextField(
                    controller: wtController,
                    decoration: InputDecoration(
                      label: Text("Enter your Weight (kg)"),
                      prefixIcon: Icon(Icons.line_weight_rounded),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 11),
                  TextField(
                    controller: ftController,
                    decoration: InputDecoration(
                      label: Text("Enter your Height (ft)"),
                      prefixIcon: Icon(Icons.height_rounded),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 11),
                  TextField(
                    controller: itController,
                    decoration: InputDecoration(
                      label: Text("Enter your Height (inch)"),
                      prefixIcon: Icon(Icons.height_sharp),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var wt = wtController.text.toString();
                      var ft = ftController.text.toString();
                      var it = itController.text.toString();

                      if (wt != "" && ft != "" && it != "") {
                        var iWt = int.parse(wt);
                        var iFt = int.parse(ft);
                        var iIt = int.parse(it);
                        var total_inch = (12 * iFt) + iIt;

                        var total_cm = 2.54 * total_inch;

                        var total_m = total_cm / 100;

                        var bmi = iWt / (total_m * total_m);

                        var msg = "";

                        if (bmi > 25) {
                          msg = "You are Over Weight !!";
                          bgcolor = Colors.orange.shade500;
                        } else if (bmi < 18) {
                          msg = "You are Under Weight !!";
                          bgcolor = Colors.red.shade500;
                        } else {
                          msg = "You are Healthy !!";
                          bgcolor = Colors.green.shade600;
                        }
                        setState(() {
                          result = "$msg\nYour BMI : ${bmi.toStringAsFixed(2)}";
                        });
                      } else {
                        setState(() {
                          result = "Please more field required";
                        });
                      }
                    },
                    child: Text(
                      "CALCULATE",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 255, 7, 143))),
                  ),
                  SizedBox(height: 35),

                  Text(
                    result,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  // Container(
                  //   width: 350,
                  //   height: 125,
                  //   child: Center(
                  //     child: Text(
                  //       result,
                  //       style: TextStyle(fontSize: 20, color: Colors.white),
                  //     ),
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Color.fromARGB(255, 211, 147, 19),
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}

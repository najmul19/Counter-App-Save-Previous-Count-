import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Counter());
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

int cnt = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  increment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ++cnt;
    setState(() {});
    pref.setInt("cntVal", cnt);
  }

  decrement() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (cnt > 0) {
      --cnt;
      setState(() {});
      pref.setInt("cntVal", cnt);
    }
  }

  @override
  void initState() {
    action();
    super.initState();
  }

  action() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? cntValue = pref.getInt("cntVal");
    cnt = cntValue ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade50,
        title: const Text(
          "Counter",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 85,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Center(
                    child: CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 15,
                      backgroundColor: Colors.deepPurple.shade100,
                      progressColor: Colors.deepPurple.shade500,
                      percent: (cnt / 100).clamp(0.0, 1.0),
                      center: Center(
                        child: Text(
                          cnt.toString(),
                          style: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        cnt = 0;
                        setState(() {});
                      },
                      child: const Text("Refresh"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 15,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (cnt > 0) decrement();
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (cnt < 100) increment();
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.plus,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

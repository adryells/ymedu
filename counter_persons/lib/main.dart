import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  bool get isEmpty => count == 0;
  bool get isFull => count == 20;

  void decrement() {
    setState(() {
      count--;
    });
  }

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contador de pessoas"),
        backgroundColor: Colors.black87,
        titleSpacing: 25,
      ),
      drawer: const Drawer(
        backgroundColor: Colors.black,
        child: DrawerChild(),
      ),
      backgroundColor: Colors.redAccent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/image.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFull ? "Tá lotado!" : "Pode entrar!",
              style: TextStyle(
                color: isFull ? Colors.red : Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
                wordSpacing: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(90),
              child: Text(
                count.toString(),
                style: const TextStyle(fontSize: 100, color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: !isEmpty ? Colors.white : Colors.black38,
                    fixedSize: const Size(100, 100),
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: !isEmpty ? decrement : null,
                  autofocus: true,
                  child: Text("Saiu",
                      style: TextStyle(
                        color: isEmpty ? Colors.white : Colors.black,
                        fontSize: 25,
                      )),
                ),
                const SizedBox(
                  width: 70,
                ),
                TextButton(
                  onPressed: !isFull ? increment : null,
                  autofocus: true,
                  style: TextButton.styleFrom(
                      backgroundColor: !isFull ? Colors.white : Colors.black38,
                      fixedSize: const Size(100, 100),
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                  child: Text("Entrou",
                      style: TextStyle(
                        color: isEmpty ? Colors.black : Colors.red,
                        fontSize: 25,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerChild extends StatelessWidget {
  const DrawerChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text(
        "This is the drawer child.",
      ),
      alignment: Alignment.center,
    );
  }
}

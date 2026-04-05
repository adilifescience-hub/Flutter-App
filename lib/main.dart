import 'package:flutter/material.dart';

void main() {
  runApp(ReaditApp());
}

class ReaditApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Readit',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Readit Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Enter Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(username: nameController.text),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen({required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int points = 0;

  final List<String> books = [
    "Focus Power",
    "Success Habits",
    "Mind Growth"
  ];

  void addPoints(int p) {
    setState(() {
      points += p;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.username}"),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: Text("Points: $points")),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index]),
            onTap: () async {
              int earned = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReadingScreen(book: books[index]),
                ),
              );
              if (earned != null) addPoints(earned);
            },
          );
        },
      ),
    );
  }
}

class ReadingScreen extends StatefulWidget {
  final String book;
  ReadingScreen({required this.book});

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      setState(() => seconds++);
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text("Reading content here...\n\nTime: $seconds sec"),
          ),
          ElevatedButton(
            child: Text("Finish & Take Quiz"),
            onPressed: () async {
              int result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizScreen()),
              );
              Navigator.pop(context, result);
            },
          )
        ],
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Did you read properly?"),
          ElevatedButton(
            child: Text("Yes"),
            onPressed: () {
              score = 10;
              Navigator.pop(context, score);
            },
          ),
          ElevatedButton(
            child: Text("No"),
            onPressed: () {
              Navigator.pop(context, 0);
            },
          )
        ],
      ),
    );
  }
}

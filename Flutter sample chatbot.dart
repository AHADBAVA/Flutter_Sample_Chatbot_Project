import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Specify the initial route
      routes: {
        '/': (context) => ScreenOne(), // Define the initial route
        '/screenTwo': (context) => ScreenTwo(), // Define a route for ScreenTwo
      },
    );
  }
}

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to ScreenTwo
            Navigator.of(context).pushNamed('/screenTwo');
          },
          child: Text("Chat Now"),
        ),
      ),
    );
  }
}

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  TextEditingController _messageController = TextEditingController();
  List<String> messages = [];

  // A simple chatbot function
  String chatBotResponse(String message) {
    message = message.toLowerCase();
    if (message == "hi") {
      return "Hello!";
    } else {
      return "I didn't understand that.";
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]),
                  );
                },
              ),
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type your message...",
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle sending the message here
                String message = _messageController.text;
                if (message.isNotEmpty) {
                  setState(() {
                    messages.add("You: $message"); // Add user's message
                    // Add chatbot's response
                    messages.add("Responds: ${chatBotResponse(message)}");
                  });
                }
                // Clear the text field
                _messageController.clear();
              },
              child: Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:example_grpc/hello.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Controller());
  }
}

class Controller extends StatefulWidget {
  const Controller({Key? key}) : super(key: key);

  @override
  TextState createState() => TextState();
}

class TextState extends State {
  String textToDisplay = "None";
  changeText(String text) {
    setState(() {
      textToDisplay = text;
    });
  }

  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () async {
                    ClientChannel channel = ClientChannel(
                        "XXX",
                        port: 50051,
                        options: const ChannelOptions(
                            credentials: ChannelCredentials.insecure(),
                            idleTimeout: Duration(minutes: 1)
                        ));
                    var service = HelloClient(channel);
                    Input input = Input.create();
                    input.input = controller.text;
                    changeText((await service.echo(input)).output);
                  },
                      icon: const Icon(Icons.send))
              ),
            ),
            Text(textToDisplay)],
        ));
  }
}

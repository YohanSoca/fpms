import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpms/bloc/mqtt_bloc.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({Key? key}) : super(key: key);

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  @override
  Widget build(BuildContext context) {
    final mqttBloc = BlocProvider.of<MqttBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Logs"),
        ),
        body: BlocBuilder<MqttBloc, MqttState>(
          builder: (context, message) => mqttBloc.state is MessageReceivedState
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                   Center(
                     child:  Text(
                       "Comming soon",
                       style: TextStyle(fontSize: 24, color: Colors.red),
                     ),
                   )
                  ],
                ))
              : Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(color: Colors.orange),
                      Text(
                          "Please check to setup if loading takes more than 3 seconds")
                    ],
                  ),
                ),
        ));
  }
}

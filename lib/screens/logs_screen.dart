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
                  children: mqttBloc.fpms.pms.logs.general.map((log) {
                    return Container(
                      height: 120,
                      width: double.infinity / 1.2,
                      margin: EdgeInsets.all(6),
                      child: Card(
                        child: Column(
                          children: log["data"].length > 10 ? [
                            Text("Timestamp: ${log["data"].sublist(0, 4)}", style: TextStyle(fontSize: 20, color: Colors.red),),
                            Text("Dev, Code: ${log["data"].sublist(4, 6).reversed.toList()}", style: TextStyle(fontSize: 20, color: Colors.red),),
                            Text("Reg address: ${log["data"].sublist(6, 8).reversed.toList()}", style: TextStyle(fontSize: 20, color: Colors.red),),
                            Text("Data: ${log["data"].sublist(8, 12).reversed.toList()}", style: TextStyle(fontSize: 20, color: Colors.red),),
                          ] : [],
                        )
                      ),
                    );
                  }).toList(),
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

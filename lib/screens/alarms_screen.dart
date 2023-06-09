import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpms/bloc/mqtt_bloc.dart';

class AlarmsScreen extends StatefulWidget {
  const AlarmsScreen({Key? key}) : super(key: key);

  @override
  State<AlarmsScreen> createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends State<AlarmsScreen> {
  @override
  Widget build(BuildContext context) {
    final mqttBloc = BlocProvider.of<MqttBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Alarms"),
        ),
        body: BlocBuilder<MqttBloc, MqttState>(
          builder: (context, message) => mqttBloc.state is MessageReceivedState
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(16),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: mqttBloc.fpms.port.alarms.lowVoltage
                                    ? Colors.red
                                    : Colors.green),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Shore A Voltage"),
                                Text(
                                    "${mqttBloc.fpms.port.alarms.lowVoltage ? "is Too Low" : "OK"}")
                              ],
                            ),
                          )
                        ],
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

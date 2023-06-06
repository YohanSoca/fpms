import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpms/bloc/mqtt_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../mqtt/mqtt_handler.dart';

class ModesScreen extends StatefulWidget {
  const ModesScreen({Key? key}) : super(key: key);

  @override
  State<ModesScreen> createState() => _ModesScreenState();
}

class _ModesScreenState extends State<ModesScreen> {

  bool checkBit(int value, int bit) => (value & (1 << bit)) != 0;

  @override
  Widget build(BuildContext context) {
    final mqttBloc = BlocProvider.of<MqttBloc>(context);

    return BlocBuilder<MqttBloc, MqttState>(
        builder: (context, message) => Scaffold(
          appBar: AppBar(title: Text("modes"),),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mqttBloc.fpms.settings.modes.protection ? Colors
                            .green : Colors.grey
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text('Protection mode: ${mqttBloc.fpms.settings.modes.protection ? 'ON' : 'OFF'}',
                        style: TextStyle(fontSize: 24),),
                    )
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mqttBloc.fpms.settings.modes.ovr ? Colors
                            .green : Colors.grey
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text('OVR mode: ${mqttBloc.fpms.settings.modes.ovr ? 'ON' : 'OFF'}',
                        style: TextStyle(fontSize: 24),),
                    )
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mqttBloc.fpms.settings.modes.oneTimeTransfer ? Colors
                            .green : Colors.grey
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text('One Time Transfer mode: ${mqttBloc.fpms.settings.modes.oneTimeTransfer ? 'ON' : 'OFF'}',
                        style: TextStyle(fontSize: 24),),
                    )
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mqttBloc.fpms.settings.modes.protection ? Colors
                            .green : Colors.grey
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text('Protection mode: ${mqttBloc.fpms.settings.modes.protection ? 'ON' : 'OFF'}',
                        style: TextStyle(fontSize: 24),),
                    )
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mqttBloc.fpms.settings.modes.protection ? Colors
                            .green : Colors.grey
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text('Protection mode: ${mqttBloc.fpms.settings.modes.protection ? 'ON' : 'OFF'}',
                        style: TextStyle(fontSize: 24),),
                    )
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mqttBloc.fpms.settings.modes.protection ? Colors
                            .green : Colors.grey
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text('Protection mode: ${mqttBloc.fpms.settings.modes.protection ? 'ON' : 'OFF'}',
                        style: TextStyle(fontSize: 24),),
                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}

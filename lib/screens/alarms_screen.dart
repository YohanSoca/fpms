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
                  child: mqttBloc.fpms.pms.alarms.general.length > 0 ? Column(
                  children: mqttBloc.fpms.pms.alarms.general.map((alarm) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      child: alarm["active"] ? Container(
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Card(
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${alarm["name"]}"),
                              Icon(Icons.notifications_active)
                            ],
                          ),
                        ),
                      ) : const SizedBox(),
                    );
                  }).toList(),
                ) : Text('No alarms'))
              : const Center(
                  child: CircularProgressIndicator(color: Colors.orange),
                ),
        ));
  }
}

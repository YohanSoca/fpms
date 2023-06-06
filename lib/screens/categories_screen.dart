import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpms/config/bloc/config_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

import '../bloc/mqtt_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController serverUriController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  String qrcode = '';
  String config = "";
  ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    serverUriController.dispose();
    portController.dispose();
    topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mqttBloc = BlocProvider.of<MqttBloc>(context);
    final configBloc = BlocProvider.of<ConfigBloc>(context);

    return BlocBuilder<MqttBloc, MqttState>(builder: (context, message) => SingleChildScrollView(
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, message) => SingleChildScrollView(
          child: Center(
            child: Container(
              width: 350,
              height: 600,
              padding: EdgeInsets.all(16),
              child: Card(
                elevation: 16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 30,),
                    Text("${config}"),
                    ElevatedButton(
                        onPressed: () async {
                          XFile? res = await picker.pickImage(source: ImageSource.gallery);
                          if (res != null) {
                            String? str = await Scan.parse(res.path);
                            if (str != null) {
                              setState(() {
                                const asciiDecoder = AsciiDecoder();
                                config = asciiDecoder.convert(str.split(' ').reversed.map((item) => int.parse(item, radix: 16)).toList()).toString();
                              });
                            }
                          }
                        }, child: Text("load json config")),
                    Text("Username: ${mqttBloc.username}", style: TextStyle(fontSize: 20),),
                    Text("Password: ${mqttBloc.password}", style: TextStyle(fontSize: 20),),
                    Text("Server uri: ${mqttBloc.serverUri}", style: TextStyle(fontSize: 20),),
                    Text("Server port: ${mqttBloc.port}", style: TextStyle(fontSize: 20),),
                    Text("${mqttBloc.fpms.serial.wiresReversed ? "Please swap rs485m wires" : ""}"),
                    SizedBox(height: 30,),
                    ElevatedButton(
                      child: Text("Select Conf QR"),
                      onPressed: () async {
                        XFile? res = await picker.pickImage(source: ImageSource.gallery);
                        if (res != null) {
                          String? str = await Scan.parse(res.path);
                          if (str != null) {
                            setState(() {
                              const asciiDecoder = AsciiDecoder();
                              qrcode = asciiDecoder.convert(str.split(' ').reversed.map((item) => int.parse(item, radix: 16)).toList()).toString();
                              if(qrcode.split('#').length > 4) {
                                mqttBloc.add(UpdateServerEvent(qrcode.split('#')[0]));
                                mqttBloc.add(UpdatePortEvent(int.parse(qrcode.split('#')[1])));
                                mqttBloc.add(UpdateTopicEvent(qrcode.split('#')[2]));
                                mqttBloc.add(UpdateCredentialsEvent(qrcode.split('#')[3], qrcode.split('#')[4]));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("The configuration QR is wrong"), duration: Duration(milliseconds: 3000),));
                              }
                            });
                          }
                        }
                      },
                    ),
                    ElevatedButton(onPressed: () {
                      mqttBloc.add(ConnectEvent());
                    }, child: Text("connect")),
                    ElevatedButton(onPressed: () {
                      mqttBloc.add(DisconnectEvent());
                    }, child: Text("disconnect")),
                    mqttBloc.state is MessageReceivedState ?
                    Column(
                      children: [
                        Text("Connected", style: TextStyle(fontSize: 30),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Heartbeat"),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: mqttBloc.fpms.heartbeat ? Colors.red : Colors.green,
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                        Text("Packages Received: ${mqttBloc.packages_received}"),
                        Text("COM: ${mqttBloc.fpms.serial.text.split(':')[1]}", style: TextStyle(fontSize: 18),)
                      ],
                    ) : Text("Disconnected", style: TextStyle(fontSize: 30),),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )
          ),
        )
      ),
    ));
  }
}

// Column(
// children: [
// Text("${qrcode.split('#').length >= 4 ? "Data valid" : "Wrong qr"}"),
// qrcode.split('#').length > 4 ? Column(
// children: [
// Text("Server uri: ${qrcode.split('#')[0]}"),
// Text("Server port: ${qrcode.split('#')[1]}"),
// Text("Topic: ${qrcode.split('#')[2]}"),
// Text("User: ${qrcode.split('#')[3]}"),
// Text("Password: ${qrcode.split('#')[4]}"),
// ],
// ) : Text("wrong data"),


// Text("${mqttBloc.serverUri}"),
// Text("${mqttBloc.port}"),
// Text("${mqttBloc.topics}"),
// TextField(
// controller: serverUriController,
// ),
// TextButton(onPressed: () {
// mqttBloc.add(UpdateServerEvent(serverUriController.text));
// }, child: Text("update")),
// TextButton(onPressed: () {
// mqttBloc.add(ConnectEvent());
// }, child: Text("connect")),
// TextButton(onPressed: () {
// mqttBloc.add(DisconnectEvent());
// }, child: Text("disconnect")),
// TextButton(onPressed: () {
// mqttBloc.add(SendMessageEvent("elmio", jsonEncode('[{"amp": {"chnnel1": 30}}]')));
// }, child: Text("publish")),
// mqttBloc.state is MessageReceivedState ? Text("${mqttBloc.fpms.shoreA.meters[0]}") : Text("diconnected")
// ],
// ),

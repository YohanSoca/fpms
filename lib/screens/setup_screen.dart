import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpms/config/bloc/config_bloc.dart';
import 'package:fpms/models/config_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

import '../bloc/mqtt_bloc.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  TextEditingController serverUriController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  String qrcode = '';
  ImagePicker picker = ImagePicker();
  bool config_ready = false;
  String jsonData = "";

  late Config config;
  bool configReady = false;

  @override
  void dispose() {
    serverUriController.dispose();
    portController.dispose();
    topicController.dispose();
    super.dispose();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
    await rootBundle.loadString('assets/config.json');
    final data = await json.decode(response);
    config = Config.fromJson(data);
    configReady = true;
  }

  @override
  Widget build(BuildContext context) {
    final mqttBloc = BlocProvider.of<MqttBloc>(context);
    final configBloc = BlocProvider.of<ConfigBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Setup"),),
      body: BlocBuilder<MqttBloc, MqttState>(builder: (context, message) => SingleChildScrollView(
        child: BlocBuilder<ConfigBloc, ConfigState>(
            builder: (context, message) => SingleChildScrollView(
              child: Center(
                  child: Container(
                    width: 350,
                    height: 500,
                    padding: EdgeInsets.all(16),
                    child: Card(
                      elevation: 16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30,),
                          ElevatedButton(
                            child: const Text("Browse QR"),
                            onPressed: () async {
                              XFile? res = await picker.pickImage(source: ImageSource.gallery);
                              if (res != null) {
                                String? str = await Scan.parse(res.path);
                                if (str != null) {
                                  setState(() async {
                                    const asciiDecoder = AsciiDecoder();
                                    qrcode = asciiDecoder.convert(str.split(' ').reversed.map((item) => int.parse(item, radix: 16)).toList()).toString();
                                    if(qrcode.split('#').length > 4) {
                                      mqttBloc.add(UpdateServerEvent(qrcode.split('#')[0]));
                                      mqttBloc.add(UpdatePortEvent(int.parse(qrcode.split('#')[1])));
                                      mqttBloc.add(UpdateTopicEvent(qrcode.split('#')[2]));
                                      mqttBloc.add(UpdateCredentialsEvent(qrcode.split('#')[3], qrcode.split('#')[4]));
                                      await Future.delayed(Duration(seconds: 1));
                                      mqttBloc.add(ConnectEvent());
                                        config_ready = true;
                                    } else {
                                      config_ready = false;
                                      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("The configuration QR is wrong"), duration: Duration(milliseconds: 3000),));
                                    }
                                  });
                                }
                              }
                            },
                          ),
                          mqttBloc.state is MessageReceivedState ?
                          Column(
                            children: [
                              Text("${mqttBloc.fpms.mobileApp.token.length > 10 ?
                              "App registered" : "Not registered yet"}", style: TextStyle(fontSize: 22),),
                              Text("${(DateTime.now().millisecondsSinceEpoch - mqttBloc.fpms.pmsServer.lastUpdate)  / 1000 < 5 ?
                              "FPMS online" : "FPMS offline"}", style: TextStyle(fontSize: 22),),
                              SizedBox(height: 20,),
                              Text("Connected", style: TextStyle(fontSize: 22),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Server Heartbeat", style: TextStyle(fontSize: 22),),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: mqttBloc.fpms.pmsServer.heartbeat ? Colors.red : Colors.green,
                                        borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("FPMS Heartbeat", style: TextStyle(fontSize: 22),),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: mqttBloc.fpms.serial.heartbeat ? Colors.red : Colors.green,
                                        borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text("Frames: ${mqttBloc.packages_received}", style: TextStyle(fontSize: 26),),
                              )
                            ],
                          ) : Text("Disconnected", style: TextStyle(fontSize: 26),),
                          SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  )
              ),
            )
        ),
      )),
    );
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

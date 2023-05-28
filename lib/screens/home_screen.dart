import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpms/bloc/mqtt_bloc.dart';
import 'package:fpms/screens/categories_screen.dart';
import 'package:fpms/screens/stbd_gen_screen.dart';
import 'dart:math' as math;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

import '../models/payload.dart';
import '../mqtt/mqtt_handler.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  late AnimationController animationController;
  int _counter = 0;

  late Timer timer;

  @override
  Widget build(BuildContext context) {
      return MediaQuery.of(context).orientation == Orientation.portrait
          ? PortraitHomeScreen()
          : LandscapeHomeScreen();
  }
}

class LandscapeHomeScreen extends StatefulWidget {
  const LandscapeHomeScreen({Key? key}) : super(key: key);

  @override
  State<LandscapeHomeScreen> createState() => _LandscapeHomeScreenState();
}

class _LandscapeHomeScreenState extends State<LandscapeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var available_height = MediaQuery.of(context).size.height;
    var available_width = MediaQuery.of(context).size.width;

    final mqttBloc = BlocProvider.of<MqttBloc>(context);

    return BlocBuilder<MqttBloc, MqttState>(
      builder: (context, message) => mqttBloc.state is MessageReceivedState ?
      SingleChildScrollView(
        child: Column(
          children: [
            // Header buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 80,
                      height: 60,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Logo.png"),
                          )),
                    ),
                    Container(
                      width: 60,
                      height: 30,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/alert.png"),
                          )),
                    )
                  ],
                ),
                Text(
                  'Manual mode ON',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 60,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/reset.png"),
                          )),
                    ),
                    Container(
                      width: 80,
                      height: 60,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Logo.png"),
                          )),
                    )
                  ],
                )
              ],
            ),
            // Pms layout
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: mqttBloc.fpms.shoreA.meters[0] > 50 ? Colors.green : Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          width: available_width / 5,
                          height: available_height / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50,
                                child: Image.asset('assets/images/generator.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  padding: EdgeInsets.all(6),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} V',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} A',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} Hz',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          color: mqttBloc.fpms.port.status.online ? Colors.green : Colors.grey,
                          height: 20,
                          width: 30,
                        ),
                        Transform.rotate(
                          angle: mqttBloc.fpms.port.status.online ?
                          0 : 45,
                          child: Container(
                            color: mqttBloc.fpms.port.status.online ? Colors.green : Colors.grey,
                            width: 40,
                            height: 20,
                          ),
                        ),
                        Container(
                          color: mqttBloc.fpms.port.status.online ? Colors.green : Colors.grey,
                          height: 20,
                          width: 30,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: mqttBloc.fpms.shoreA.meters[0] > 50 ?
                                Colors.green : Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          width: available_width / 5,
                          height: available_height / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50,
                                child:
                                Image.asset('assets/images/shore_plug.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  padding: EdgeInsets.all(6),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} V',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} A',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} Hz',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                          height: 20,
                          width: 30,
                        ),
                        Transform.rotate(
                          angle: mqttBloc.fpms.shoreA.status.online ? 0 : 45,
                          child: Container(
                            color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                            width: 40,
                            height: 20,
                          ),
                        ),
                        Container(
                          color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                          height: 20,
                          width: 30,
                        )
                      ],
                    ),
                  ],
                ),
                //Main bus A
                Container(
                  width: 20,
                  height: 200,
                  child: Container(
                    color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                    height: double.infinity,
                    width: 20,
                  ),
                ),
                //Tie breaker row
                Container(
                  margin: EdgeInsets.only(top: 180),
                  child: Row(
                    children: [
                      Container(
                        color: Colors.white60,
                        width: 20,
                        height: 20,
                        child: Container(
                          color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                          height: double.infinity,
                          width: 20,
                        ),
                      ),
                      Transform.rotate(
                        angle: mqttBloc.fpms.shoreA.status.online ? 0 : 45,
                        child: Container(
                          color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                          width: 50,
                          height: 20,
                        ),
                      ),
                      Container(
                        color: Colors.white60,
                        width: 20,
                        height: 20,
                        child: Container(
                          color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                          height: double.infinity,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                // Main bus bar B
                Container(
                  margin: EdgeInsets.only(left: 0),
                  color: Colors.white60,
                  width: 20,
                  height: 200,
                  child: Container(
                    color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                    height: double.infinity,
                    width: 20,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                          height: 20,
                          width: 30,
                        ),
                        Transform.rotate(
                          angle: mqttBloc.fpms.shoreA.status.online ? 0 : 45,
                          child: Container(
                            color: Colors.grey,
                            width: 40,
                            height: 20,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                          height: 20,
                          width: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 15),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          width: available_width / 4.8,
                          height: available_height / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(6),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} V',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} A',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} Hz',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 50,
                                child: Image.asset('assets/images/generator.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                          height: 20,
                          width: 30,
                        ),
                        Transform.rotate(
                          angle: mqttBloc.fpms.shoreA.status.online ? 0 : 45,
                          child: Container(
                            color: mqttBloc.fpms.shoreA.status.online ? Colors.green : Colors.grey,
                            width: 40,
                            height: 20,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          color: mqttBloc.fpms.shoreA.meters[0] > 50 ? Colors.green : Colors.grey,
                          height: 20,
                          width: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: mqttBloc.fpms.shoreA.meters[0] > 50 ? Colors.green : Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          width: available_width / 4.8,
                          height: available_height / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(6),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} V',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} A',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      Text(
                                        '${mqttBloc.fpms.shoreA.meters[0]} Hz',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 50,
                                child:
                                Image.asset('assets/images/shore_plug.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ) : Center(
        child: Column(
          children: [
            CircularProgressIndicator(color: Colors.orange),
            Text("Please check to setup if loading takes more than 3 seconds")
          ],
        ),
      ),
    );
  }
}

class PortraitHomeScreen extends StatefulWidget {

  const PortraitHomeScreen({Key? key})
      : super(key: key);

  @override
  State<PortraitHomeScreen> createState() => _PortraitHomeScreenState();
}

class _PortraitHomeScreenState extends State<PortraitHomeScreen> {

  @override
  Widget build(BuildContext context) {
    final mqttBloc = BlocProvider.of<MqttBloc>(context);

    var available_height = MediaQuery.of(context).size.height;

    return BlocBuilder<MqttBloc, MqttState>(
      builder: (contenxt, message) => mqttBloc.state is MessageReceivedState ?
        Row(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                PowerSource(mqttBloc.fpms.port),
                PowerSource(mqttBloc.fpms.shoreA),
                PowerSource(mqttBloc.fpms.stbd),
                PowerSource(mqttBloc.fpms.shoreB)
              ],
            ),
          ),
          Column(
            children: [
              Expanded(
                  child: Container( // Bus bar A
                    width: 20,
                    color: mqttBloc.fpms.pms.feedback.inputs[0] ? Colors.green : Colors.grey,
                  )),
              Transform.rotate( // Tie breaker
                angle: mqttBloc.fpms.pms.feedback.inputs[0]
                    ? 0
                    : 45,
                child: Container(
                  color: mqttBloc.fpms.pms.feedback.inputs[0] ? Colors.green : Colors.grey,
                  width: 20,
                  height: available_height / 14,
                ),
              ),
              Expanded(
                  child: Container( // Bus bar B
                    width: 20,
                    color: mqttBloc.fpms.pms.feedback.inputs[0] ? Colors.green : Colors.grey,
                  ))
            ],
          )
        ],
      ) : Center(child: CircularProgressIndicator(color: Colors.orange),),
    );
  }
}

class PowerSource extends StatefulWidget {
  final dynamic payload;
  const PowerSource(this.payload, {Key? key})
      : super(key: key);

  @override
  State<PowerSource> createState() => _PowerSourceState();
}

class _PowerSourceState extends State<PowerSource> {
  @override
  Widget build(BuildContext context) {

    var available_height = MediaQuery.of(context).size.height;
    var available_width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StbdGenScreen()));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 3, top: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: widget.payload.meters[0] >
                            100
                        ? Colors.green
                        : Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              width: available_width / 2.2,
              height: available_height / 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60,
                    child: Card(color: Colors.transparent ,elevation: 8, child: Image.asset('assets/images/${widget.payload.imageUri}'),),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.payload.meters[0].toString() ?? '0'} V',
                            style: const TextStyle(fontSize: 22),
                          ),
                          Text(
                            '${widget.payload.meters[0].toString() ?? '0'} A',
                            style: const TextStyle(fontSize: 22),
                          ),
                          Text(
                            '${widget.payload.meters[0].toString() ?? '0'} Hz',
                            style: const TextStyle(fontSize: 22),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Container( // Feeder
            width: 40,
            height: 20,
            decoration: BoxDecoration(color: widget.payload.meters[0] >
                100
                ? Colors.green
                : Colors.grey,),
          ),
          Transform.rotate( // Breaker
            angle: widget.payload.status.online
                ? 0
                : 45,
            child: Container(
              color: widget.payload.status.online
                  ? Colors.green
                  : Colors.grey,
              width: available_width / 8,
              height: 20,
            ),
          ),
          Container( // Main bus drop
            color: widget.payload.status.online ?
                 Colors.green
                : Colors.grey,
            width: available_width / 8,
            height: 20,
          )
        ],
      ),
    );
  }
}

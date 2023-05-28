import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fpms/models/fpms.dart';
import 'package:fpms/mqtt/mqtt_handler.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';

part 'mqtt_event.dart';
part 'mqtt_state.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  MQTTClientManager _clientManager = MQTTClientManager();
  String serverUri = "";
  String username = "";
  String password = "";
  int port = 0;
  List<String> topics = [];
  String message = 'empty';
  bool connected = false;
  late Fpms fpms;
  int packages_received = 0;
  String status = "";

  MqttBloc() : super(DisconnectedState()) {

    on<UpdateCredentialsEvent>((event, emit) {
        username = event.username;
        password = event.password;

        emit(UpdateCredentialsState(username, password));
    });

    on<UpdateTopicEvent>((event, emit) {
      topics.add(event.topic);
    });

    on<UpdateServerEvent>((event, emit) async {
      serverUri = event.serverUri;
      emit(UpdateServerUriState(event.serverUri));
    });

    on<UpdatePortEvent>((event, emit) async {
      port = event.port;
      emit(UpdateServerPortState(event.port));
    });

    on<ConnectEvent>((event, emit) async {
      //TODO
      if(connected) {
        _clientManager.disconnect();
        _clientManager.client.disconnect();
      }
      MqttServerClient serverClient = MqttServerClient(serverUri, '');
      await _clientManager.connect(serverClient, username, password);
      status = _clientManager.respose;
      for(String topic in topics) {
        _clientManager.subscribe(topic);
      }
      await setupUpdatesListener();

      if(_clientManager.client.connectionStatus!.state ==
          MqttConnectionState.connected) {
        add(ConnectedEvent());
      }
    });

    on<SendMessageEvent>((event, emit) {
      //TODO
      _clientManager.publishMessage(event.topic, event.message);
    });
    on<MessageReceivedEvent>((event, emit) {
      //TODO
      packages_received = packages_received + 1;
      emit(MessageReceivedState(event.message));
    });

    on<ConnectedEvent>((event, emit) {
      //TODO
      emit(ConnectedState(true));
    });

    on<DisconnectEvent>((event, emit) {
      //TODO
      for(String topic in topics) {
        _clientManager.client.unsubscribe(topic);
      }
      _clientManager.disconnect();

      packages_received = 0;

      emit(ConnectedState(false));
    });
  }

  Future<void> setupUpdatesListener() async {
    _clientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      //print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
      if (_clientManager.client.connectionStatus!.state ==
          MqttConnectionState.connected) {
        if(c[0].topic == "fpms") {
          fpms = Fpms.fromJson(json.decode(pt));
          this.message = pt;
          add(MessageReceivedEvent(pt));
        }
      }
    });
  }

}
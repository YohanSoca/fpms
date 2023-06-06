// To parse this JSON data, do
//
//     final fpms = fpmsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Fpms {
  String username;
  String email;
  String password;
  bool demo;
  String mqttServerUri;
  int mqttServerPort;
  String mqttUsername;
  String mqttPassword;
  List<dynamic> mqttTopics;
  int profile;

  Fpms({
    required this.username,
    required this.email,
    required this.password,
    required this.demo,
    required this.mqttServerUri,
    required this.mqttServerPort,
    required this.mqttUsername,
    required this.mqttPassword,
    required this.mqttTopics,
    required this.profile,
  });

  Fpms copyWith({
    String? username,
    String? email,
    String? password,
    bool? demo,
    String? mqttServerUri,
    int? mqttServerPort,
    String? mqttUsername,
    String? mqttPassword,
    List<dynamic>? mqttTopics,
    int? profile,
  }) =>
      Fpms(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        demo: demo ?? this.demo,
        mqttServerUri: mqttServerUri ?? this.mqttServerUri,
        mqttServerPort: mqttServerPort ?? this.mqttServerPort,
        mqttUsername: mqttUsername ?? this.mqttUsername,
        mqttPassword: mqttPassword ?? this.mqttPassword,
        mqttTopics: mqttTopics ?? this.mqttTopics,
        profile: profile ?? this.profile,
      );

  factory Fpms.fromRawJson(String str) => Fpms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fpms.fromJson(Map<String, dynamic> json) => Fpms(
    username: json["username"],
    email: json["email"],
    password: json["password"],
    demo: json["demo"],
    mqttServerUri: json["mqtt_server_uri"],
    mqttServerPort: json["mqtt_server_port"],
    mqttUsername: json["mqtt_username"],
    mqttPassword: json["mqtt_password"],
    mqttTopics: List<dynamic>.from(json["mqtt_topics"].map((x) => x)),
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
    "demo": demo,
    "mqtt_server_uri": mqttServerUri,
    "mqtt_server_port": mqttServerPort,
    "mqtt_username": mqttUsername,
    "mqtt_password": mqttPassword,
    "mqtt_topics": List<dynamic>.from(mqttTopics.map((x) => x)),
    "profile": profile,
  };
}

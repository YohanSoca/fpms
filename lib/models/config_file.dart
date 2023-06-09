// To parse this JSON data, do
//
//     final config = configFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Config {
  String username;
  String email;
  String password;
  bool demo;
  String mqttServerUri;
  int mqttServerPort;
  String mqttUsername;
  String mqttPassword;
  List<String> mqttTopics;
  int profile;

  Config({
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

  Config copyWith({
    String? username,
    String? email,
    String? password,
    bool? demo,
    String? mqttServerUri,
    int? mqttServerPort,
    String? mqttUsername,
    String? mqttPassword,
    List<String>? mqttTopics,
    int? profile,
  }) =>
      Config(
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

  factory Config.fromRawJson(String str) => Config.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    username: json["username"],
    email: json["email"],
    password: json["password"],
    demo: json["demo"],
    mqttServerUri: json["mqtt_server_uri"],
    mqttServerPort: json["mqtt_server_port"],
    mqttUsername: json["mqtt_username"],
    mqttPassword: json["mqtt_password"],
    mqttTopics: List<String>.from(json["mqtt_topics"].map((x) => x)),
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

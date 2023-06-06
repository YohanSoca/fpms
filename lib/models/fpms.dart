// To parse this JSON data, do
//
//     final fpms = fpmsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Fpms {
  bool heartbeat;
  Serial serial;
  Shore shoreA;
  Shore shoreB;
  Port port;
  Port stbd;
  Pms pms;
  Settings settings;
  MobileApp mobileApp;

  Fpms({
    required this.heartbeat,
    required this.serial,
    required this.shoreA,
    required this.shoreB,
    required this.port,
    required this.stbd,
    required this.pms,
    required this.settings,
    required this.mobileApp,
  });

  Fpms copyWith({
    bool? heartbeat,
    Serial? serial,
    Shore? shoreA,
    Shore? shoreB,
    Port? port,
    Port? stbd,
    Pms? pms,
    Settings? settings,
    MobileApp? mobileApp,
  }) =>
      Fpms(
        heartbeat: heartbeat ?? this.heartbeat,
        serial: serial ?? this.serial,
        shoreA: shoreA ?? this.shoreA,
        shoreB: shoreB ?? this.shoreB,
        port: port ?? this.port,
        stbd: stbd ?? this.stbd,
        pms: pms ?? this.pms,
        settings: settings ?? this.settings,
        mobileApp: mobileApp ?? this.mobileApp,
      );

  factory Fpms.fromRawJson(String str) => Fpms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fpms.fromJson(Map<String, dynamic> json) => Fpms(
    heartbeat: json["heartbeat"],
    serial: Serial.fromJson(json["serial"]),
    shoreA: Shore.fromJson(json["shoreA"]),
    shoreB: Shore.fromJson(json["shoreB"]),
    port: Port.fromJson(json["port"]),
    stbd: Port.fromJson(json["stbd"]),
    pms: Pms.fromJson(json["pms"]),
    settings: Settings.fromJson(json["settings"]),
    mobileApp: MobileApp.fromJson(json["mobile_app"]),
  );

  Map<String, dynamic> toJson() => {
    "heartbeat": heartbeat,
    "serial": serial.toJson(),
    "shoreA": shoreA.toJson(),
    "shoreB": shoreB.toJson(),
    "port": port.toJson(),
    "stbd": stbd.toJson(),
    "pms": pms.toJson(),
    "settings": settings.toJson(),
    "mobile_app": mobileApp.toJson(),
  };
}

class MobileApp {
  bool connected;
  String token;
  String email;
  String passqord;

  MobileApp({
    required this.connected,
    required this.token,
    required this.email,
    required this.passqord,
  });

  MobileApp copyWith({
    bool? connected,
    String? token,
    String? email,
    String? passqord,
  }) =>
      MobileApp(
        connected: connected ?? this.connected,
        token: token ?? this.token,
        email: email ?? this.email,
        passqord: passqord ?? this.passqord,
      );

  factory MobileApp.fromRawJson(String str) => MobileApp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MobileApp.fromJson(Map<String, dynamic> json) => MobileApp(
    connected: json["connected"],
    token: json["token"],
    email: json["email"],
    passqord: json["passqord"],
  );

  Map<String, dynamic> toJson() => {
    "connected": connected,
    "token": token,
    "email": email,
    "passqord": passqord,
  };
}

class Pms {
  Requests requests;
  Feedback feedback;

  Pms({
    required this.requests,
    required this.feedback,
  });

  Pms copyWith({
    Requests? requests,
    Feedback? feedback,
  }) =>
      Pms(
        requests: requests ?? this.requests,
        feedback: feedback ?? this.feedback,
      );

  factory Pms.fromRawJson(String str) => Pms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pms.fromJson(Map<String, dynamic> json) => Pms(
    requests: Requests.fromJson(json["requests"]),
    feedback: Feedback.fromJson(json["feedback"]),
  );

  Map<String, dynamic> toJson() => {
    "requests": requests.toJson(),
    "feedback": feedback.toJson(),
  };
}

class Feedback {
  bool busALive;
  bool busBLive;
  bool tieBreakerClosed;
  bool blackout;
  List<dynamic> inputs;
  bool inProgress;
  List<dynamic> errors;
  String response;

  Feedback({
    required this.busALive,
    required this.busBLive,
    required this.tieBreakerClosed,
    required this.blackout,
    required this.inputs,
    required this.inProgress,
    required this.errors,
    required this.response,
  });

  Feedback copyWith({
    bool? busALive,
    bool? busBLive,
    bool? tieBreakerClosed,
    bool? blackout,
    List<dynamic>? inputs,
    bool? inProgress,
    List<dynamic>? errors,
    String? response,
  }) =>
      Feedback(
        busALive: busALive ?? this.busALive,
        busBLive: busBLive ?? this.busBLive,
        tieBreakerClosed: tieBreakerClosed ?? this.tieBreakerClosed,
        blackout: blackout ?? this.blackout,
        inputs: inputs ?? this.inputs,
        inProgress: inProgress ?? this.inProgress,
        errors: errors ?? this.errors,
        response: response ?? this.response,
      );

  factory Feedback.fromRawJson(String str) => Feedback.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    busALive: json["bus_a_live"],
    busBLive: json["bus_b_live"],
    tieBreakerClosed: json["tie_breaker_closed"],
    blackout: json["blackout"],
    inputs: List<dynamic>.from(json["inputs"].map((x) => x)),
    inProgress: json["in_progress"],
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    response: json["response"],
  );

  Map<String, dynamic> toJson() => {
    "bus_a_live": busALive,
    "bus_b_live": busBLive,
    "tie_breaker_closed": tieBreakerClosed,
    "blackout": blackout,
    "inputs": List<dynamic>.from(inputs.map((x) => x)),
    "in_progress": inProgress,
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "response": response,
  };
}

class Requests {
  bool transferToShore;
  bool transferToGen;
  bool abortTransfer;
  bool setPortAsPriority;
  bool setStbdAsPriority;

  Requests({
    required this.transferToShore,
    required this.transferToGen,
    required this.abortTransfer,
    required this.setPortAsPriority,
    required this.setStbdAsPriority,
  });

  Requests copyWith({
    bool? transferToShore,
    bool? transferToGen,
    bool? abortTransfer,
    bool? setPortAsPriority,
    bool? setStbdAsPriority,
  }) =>
      Requests(
        transferToShore: transferToShore ?? this.transferToShore,
        transferToGen: transferToGen ?? this.transferToGen,
        abortTransfer: abortTransfer ?? this.abortTransfer,
        setPortAsPriority: setPortAsPriority ?? this.setPortAsPriority,
        setStbdAsPriority: setStbdAsPriority ?? this.setStbdAsPriority,
      );

  factory Requests.fromRawJson(String str) => Requests.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Requests.fromJson(Map<String, dynamic> json) => Requests(
    transferToShore: json["transfer_to_shore"],
    transferToGen: json["transfer_to_gen"],
    abortTransfer: json["abort_transfer"],
    setPortAsPriority: json["set_port_as_priority"],
    setStbdAsPriority: json["set_stbd_as_priority"],
  );

  Map<String, dynamic> toJson() => {
    "transfer_to_shore": transferToShore,
    "transfer_to_gen": transferToGen,
    "abort_transfer": abortTransfer,
    "set_port_as_priority": setPortAsPriority,
    "set_stbd_as_priority": setStbdAsPriority,
  };
}

class Port {
  String name;
  String imageUri;
  List<dynamic> meters;
  PortStatus status;

  Port({
    required this.name,
    required this.imageUri,
    required this.meters,
    required this.status,
  });

  Port copyWith({
    String? name,
    String? imageUri,
    List<dynamic>? meters,
    PortStatus? status,
  }) =>
      Port(
        name: name ?? this.name,
        imageUri: imageUri ?? this.imageUri,
        meters: meters ?? this.meters,
        status: status ?? this.status,
      );

  factory Port.fromRawJson(String str) => Port.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Port.fromJson(Map<String, dynamic> json) => Port(
    name: json["name"],
    imageUri: json["image_uri"],
    meters: List<dynamic>.from(json["meters"].map((x) => x)),
    status: PortStatus.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image_uri": imageUri,
    "meters": List<dynamic>.from(meters.map((x) => x)),
    "status": status.toJson(),
  };
}

class PortStatus {
  bool online;

  PortStatus({
    required this.online,
  });

  PortStatus copyWith({
    bool? online,
  }) =>
      PortStatus(
        online: online ?? this.online,
      );

  factory PortStatus.fromRawJson(String str) => PortStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PortStatus.fromJson(Map<String, dynamic> json) => PortStatus(
    online: json["online"],
  );

  Map<String, dynamic> toJson() => {
    "online": online,
  };
}

class Serial {
  bool wiresReversed;
  String fill;
  String shape;
  String text;
  Source source;

  Serial({
    required this.wiresReversed,
    required this.fill,
    required this.shape,
    required this.text,
    required this.source,
  });

  Serial copyWith({
    bool? wiresReversed,
    String? fill,
    String? shape,
    String? text,
    Source? source,
  }) =>
      Serial(
        wiresReversed: wiresReversed ?? this.wiresReversed,
        fill: fill ?? this.fill,
        shape: shape ?? this.shape,
        text: text ?? this.text,
        source: source ?? this.source,
      );

  factory Serial.fromRawJson(String str) => Serial.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Serial.fromJson(Map<String, dynamic> json) => Serial(
    wiresReversed: json["wires_reversed"],
    fill: json["fill"],
    shape: json["shape"],
    text: json["text"],
    source: Source.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "wires_reversed": wiresReversed,
    "fill": fill,
    "shape": shape,
    "text": text,
    "source": source.toJson(),
  };
}

class Source {
  String id;
  String type;
  String name;

  Source({
    required this.id,
    required this.type,
    required this.name,
  });

  Source copyWith({
    String? id,
    String? type,
    String? name,
  }) =>
      Source(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
      );

  factory Source.fromRawJson(String str) => Source.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    type: json["type"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
  };
}

class Settings {
  Modes modes;

  Settings({
    required this.modes,
  });

  Settings copyWith({
    Modes? modes,
  }) =>
      Settings(
        modes: modes ?? this.modes,
      );

  factory Settings.fromRawJson(String str) => Settings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    modes: Modes.fromJson(json["modes"]),
  );

  Map<String, dynamic> toJson() => {
    "modes": modes.toJson(),
  };
}

class Modes {
  String name;
  bool protection;
  bool ovr;
  bool oneTimeTransfer;
  bool splitBus;
  bool preferedSource;
  bool preferedGen;
  bool dualGen;
  bool seamlessTransfer;
  bool nbootsShoreA;
  bool nbootsShoreB;
  bool preferedSwgear;
  bool singleShoreCombine;
  bool splitBusAutoOff;

  Modes({
    required this.name,
    required this.protection,
    required this.ovr,
    required this.oneTimeTransfer,
    required this.splitBus,
    required this.preferedSource,
    required this.preferedGen,
    required this.dualGen,
    required this.seamlessTransfer,
    required this.nbootsShoreA,
    required this.nbootsShoreB,
    required this.preferedSwgear,
    required this.singleShoreCombine,
    required this.splitBusAutoOff,
  });

  Modes copyWith({
    String? name,
    bool? protection,
    bool? ovr,
    bool? oneTimeTransfer,
    bool? splitBus,
    bool? preferedSource,
    bool? preferedGen,
    bool? dualGen,
    bool? seamlessTransfer,
    bool? nbootsShoreA,
    bool? nbootsShoreB,
    bool? preferedSwgear,
    bool? singleShoreCombine,
    bool? splitBusAutoOff,
  }) =>
      Modes(
        name: name ?? this.name,
        protection: protection ?? this.protection,
        ovr: ovr ?? this.ovr,
        oneTimeTransfer: oneTimeTransfer ?? this.oneTimeTransfer,
        splitBus: splitBus ?? this.splitBus,
        preferedSource: preferedSource ?? this.preferedSource,
        preferedGen: preferedGen ?? this.preferedGen,
        dualGen: dualGen ?? this.dualGen,
        seamlessTransfer: seamlessTransfer ?? this.seamlessTransfer,
        nbootsShoreA: nbootsShoreA ?? this.nbootsShoreA,
        nbootsShoreB: nbootsShoreB ?? this.nbootsShoreB,
        preferedSwgear: preferedSwgear ?? this.preferedSwgear,
        singleShoreCombine: singleShoreCombine ?? this.singleShoreCombine,
        splitBusAutoOff: splitBusAutoOff ?? this.splitBusAutoOff,
      );

  factory Modes.fromRawJson(String str) => Modes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Modes.fromJson(Map<String, dynamic> json) => Modes(
    name: json["name"],
    protection: json["protection"],
    ovr: json["ovr"],
    oneTimeTransfer: json["one_time_transfer"],
    splitBus: json["split_bus"],
    preferedSource: json["prefered_source"],
    preferedGen: json["prefered_gen"],
    dualGen: json["dual_gen"],
    seamlessTransfer: json["seamless_transfer"],
    nbootsShoreA: json["nboots_shore_a"],
    nbootsShoreB: json["nboots_shore_b"],
    preferedSwgear: json["prefered_swgear"],
    singleShoreCombine: json["single_shore_combine"],
    splitBusAutoOff: json["split_bus_auto_off"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "protection": protection,
    "ovr": ovr,
    "one_time_transfer": oneTimeTransfer,
    "split_bus": splitBus,
    "prefered_source": preferedSource,
    "prefered_gen": preferedGen,
    "dual_gen": dualGen,
    "seamless_transfer": seamlessTransfer,
    "nboots_shore_a": nbootsShoreA,
    "nboots_shore_b": nbootsShoreB,
    "prefered_swgear": preferedSwgear,
    "single_shore_combine": singleShoreCombine,
    "split_bus_auto_off": splitBusAutoOff,
  };
}

class Shore {
  String name;
  String imageUri;
  List<dynamic> meters;
  ShoreAStatus status;

  Shore({
    required this.name,
    required this.imageUri,
    required this.meters,
    required this.status,
  });

  Shore copyWith({
    String? name,
    String? imageUri,
    List<dynamic>? meters,
    ShoreAStatus? status,
  }) =>
      Shore(
        name: name ?? this.name,
        imageUri: imageUri ?? this.imageUri,
        meters: meters ?? this.meters,
        status: status ?? this.status,
      );

  factory Shore.fromRawJson(String str) => Shore.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shore.fromJson(Map<String, dynamic> json) => Shore(
    name: json["name"],
    imageUri: json["image_uri"],
    meters: List<dynamic>.from(json["meters"].map((x) => x)),
    status: ShoreAStatus.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image_uri": imageUri,
    "meters": List<dynamic>.from(meters.map((x) => x)),
    "status": status.toJson(),
  };
}

class ShoreAStatus {
  bool online;
  bool cordAvailable;
  bool tripped;

  ShoreAStatus({
    required this.online,
    required this.cordAvailable,
    required this.tripped,
  });

  ShoreAStatus copyWith({
    bool? online,
    bool? cordAvailable,
    bool? tripped,
  }) =>
      ShoreAStatus(
        online: online ?? this.online,
        cordAvailable: cordAvailable ?? this.cordAvailable,
        tripped: tripped ?? this.tripped,
      );

  factory ShoreAStatus.fromRawJson(String str) => ShoreAStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShoreAStatus.fromJson(Map<String, dynamic> json) => ShoreAStatus(
    online: json["online"],
    cordAvailable: json["cord_available"],
    tripped: json["tripped"],
  );

  Map<String, dynamic> toJson() => {
    "online": online,
    "cord_available": cordAvailable,
    "tripped": tripped,
  };
}

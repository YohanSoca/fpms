// To parse this JSON data, do
//
//     final fpms = fpmsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Fpms {
  MobileApp mobileApp;
  PmsServer pmsServer;
  Serial serial;
  Shore shoreA;
  Shore shoreB;
  Port port;
  Port stbd;
  Pms pms;

  Fpms({
    required this.mobileApp,
    required this.pmsServer,
    required this.serial,
    required this.shoreA,
    required this.shoreB,
    required this.port,
    required this.stbd,
    required this.pms,
  });

  Fpms copyWith({
    MobileApp? mobileApp,
    PmsServer? pmsServer,
    Serial? serial,
    Shore? shoreA,
    Shore? shoreB,
    Port? port,
    Port? stbd,
    Pms? pms,
  }) =>
      Fpms(
        mobileApp: mobileApp ?? this.mobileApp,
        pmsServer: pmsServer ?? this.pmsServer,
        serial: serial ?? this.serial,
        shoreA: shoreA ?? this.shoreA,
        shoreB: shoreB ?? this.shoreB,
        port: port ?? this.port,
        stbd: stbd ?? this.stbd,
        pms: pms ?? this.pms,
      );

  factory Fpms.fromRawJson(String str) => Fpms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fpms.fromJson(Map<String, dynamic> json) => Fpms(
    mobileApp: MobileApp.fromJson(json["mobile_app"]),
    pmsServer: PmsServer.fromJson(json["pms_server"]),
    serial: Serial.fromJson(json["serial"]),
    shoreA: Shore.fromJson(json["shoreA"]),
    shoreB: Shore.fromJson(json["shoreB"]),
    port: Port.fromJson(json["port"]),
    stbd: Port.fromJson(json["stbd"]),
    pms: Pms.fromJson(json["pms"]),
  );

  Map<String, dynamic> toJson() => {
    "mobile_app": mobileApp.toJson(),
    "pms_server": pmsServer.toJson(),
    "serial": serial.toJson(),
    "shoreA": shoreA.toJson(),
    "shoreB": shoreB.toJson(),
    "port": port.toJson(),
    "stbd": stbd.toJson(),
    "pms": pms.toJson(),
  };
}

class MobileApp {
  bool connected;
  String token;
  String email;
  String password;

  MobileApp({
    required this.connected,
    required this.token,
    required this.email,
    required this.password,
  });

  MobileApp copyWith({
    bool? connected,
    String? token,
    String? email,
    String? password,
  }) =>
      MobileApp(
        connected: connected ?? this.connected,
        token: token ?? this.token,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory MobileApp.fromRawJson(String str) => MobileApp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MobileApp.fromJson(Map<String, dynamic> json) => MobileApp(
    connected: json["connected"],
    token: json["token"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "connected": connected,
    "token": token,
    "email": email,
    "password": password,
  };
}

class Pms {
  bool hmi1Online;
  bool hmi2Online;
  bool boosted;
  Settings settings;
  Map<String, bool> status;
  Requests requests;
  PmsFeedback feedback;
  Map<String, bool> alarms;
  Logs logs;

  Pms({
    required this.hmi1Online,
    required this.hmi2Online,
    required this.boosted,
    required this.settings,
    required this.status,
    required this.requests,
    required this.feedback,
    required this.alarms,
    required this.logs,
  });

  Pms copyWith({
    bool? hmi1Online,
    bool? hmi2Online,
    bool? boosted,
    Settings? settings,
    Map<String, bool>? status,
    Requests? requests,
    PmsFeedback? feedback,
    Map<String, bool>? alarms,
    Logs? logs,
  }) =>
      Pms(
        hmi1Online: hmi1Online ?? this.hmi1Online,
        hmi2Online: hmi2Online ?? this.hmi2Online,
        boosted: boosted ?? this.boosted,
        settings: settings ?? this.settings,
        status: status ?? this.status,
        requests: requests ?? this.requests,
        feedback: feedback ?? this.feedback,
        alarms: alarms ?? this.alarms,
        logs: logs ?? this.logs,
      );

  factory Pms.fromRawJson(String str) => Pms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pms.fromJson(Map<String, dynamic> json) => Pms(
    hmi1Online: json["hmi_1_online"],
    hmi2Online: json["hmi_2_online"],
    boosted: json["boosted"],
    settings: Settings.fromJson(json["settings"]),
    status: Map.from(json["status"]).map((k, v) => MapEntry<String, bool>(k, v)),
    requests: Requests.fromJson(json["requests"]),
    feedback: PmsFeedback.fromJson(json["feedback"]),
    alarms: Map.from(json["alarms"]).map((k, v) => MapEntry<String, bool>(k, v)),
    logs: Logs.fromJson(json["logs"]),
  );

  Map<String, dynamic> toJson() => {
    "hmi_1_online": hmi1Online,
    "hmi_2_online": hmi2Online,
    "boosted": boosted,
    "settings": settings.toJson(),
    "status": Map.from(status).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "requests": requests.toJson(),
    "feedback": feedback.toJson(),
    "alarms": Map.from(alarms).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "logs": logs.toJson(),
  };
}

class PmsFeedback {
  bool contactorCombine;
  bool contactorReverse;
  bool contactorSeriesParallel;
  bool busALive;
  bool busBLive;
  bool tieBreakerClosed;
  bool blackout;
  List<dynamic> inputs;
  bool inProgress;
  List<dynamic> errors;
  String response;

  PmsFeedback({
    required this.contactorCombine,
    required this.contactorReverse,
    required this.contactorSeriesParallel,
    required this.busALive,
    required this.busBLive,
    required this.tieBreakerClosed,
    required this.blackout,
    required this.inputs,
    required this.inProgress,
    required this.errors,
    required this.response,
  });

  PmsFeedback copyWith({
    bool? contactorCombine,
    bool? contactorReverse,
    bool? contactorSeriesParallel,
    bool? busALive,
    bool? busBLive,
    bool? tieBreakerClosed,
    bool? blackout,
    List<dynamic>? inputs,
    bool? inProgress,
    List<dynamic>? errors,
    String? response,
  }) =>
      PmsFeedback(
        contactorCombine: contactorCombine ?? this.contactorCombine,
        contactorReverse: contactorReverse ?? this.contactorReverse,
        contactorSeriesParallel: contactorSeriesParallel ?? this.contactorSeriesParallel,
        busALive: busALive ?? this.busALive,
        busBLive: busBLive ?? this.busBLive,
        tieBreakerClosed: tieBreakerClosed ?? this.tieBreakerClosed,
        blackout: blackout ?? this.blackout,
        inputs: inputs ?? this.inputs,
        inProgress: inProgress ?? this.inProgress,
        errors: errors ?? this.errors,
        response: response ?? this.response,
      );

  factory PmsFeedback.fromRawJson(String str) => PmsFeedback.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PmsFeedback.fromJson(Map<String, dynamic> json) => PmsFeedback(
    contactorCombine: json["contactor_combine"],
    contactorReverse: json["contactor_reverse"],
    contactorSeriesParallel: json["contactor_series_parallel"],
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
    "contactor_combine": contactorCombine,
    "contactor_reverse": contactorReverse,
    "contactor_series_parallel": contactorSeriesParallel,
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

class Logs {
  List<dynamic> errorLogs;
  List<dynamic> eventLogs;
  List<dynamic> alarmLogs;

  Logs({
    required this.errorLogs,
    required this.eventLogs,
    required this.alarmLogs,
  });

  Logs copyWith({
    List<dynamic>? errorLogs,
    List<dynamic>? eventLogs,
    List<dynamic>? alarmLogs,
  }) =>
      Logs(
        errorLogs: errorLogs ?? this.errorLogs,
        eventLogs: eventLogs ?? this.eventLogs,
        alarmLogs: alarmLogs ?? this.alarmLogs,
      );

  factory Logs.fromRawJson(String str) => Logs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Logs.fromJson(Map<String, dynamic> json) => Logs(
    errorLogs: List<dynamic>.from(json["error_logs"].map((x) => x)),
    eventLogs: List<dynamic>.from(json["event_logs"].map((x) => x)),
    alarmLogs: List<dynamic>.from(json["alarm_logs"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error_logs": List<dynamic>.from(errorLogs.map((x) => x)),
    "event_logs": List<dynamic>.from(eventLogs.map((x) => x)),
    "alarm_logs": List<dynamic>.from(alarmLogs.map((x) => x)),
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
  bool genAutoStart;
  bool genAutoStop;

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
    required this.genAutoStart,
    required this.genAutoStop,
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
    bool? genAutoStart,
    bool? genAutoStop,
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
        genAutoStart: genAutoStart ?? this.genAutoStart,
        genAutoStop: genAutoStop ?? this.genAutoStop,
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
    genAutoStart: json["gen_auto_start"],
    genAutoStop: json["gen_auto_stop"],
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
    "gen_auto_start": genAutoStart,
    "gen_auto_stop": genAutoStop,
  };
}

class PmsServer {
  bool heartbeat;
  int mqttClients;
  int lastUpdate;

  PmsServer({
    required this.heartbeat,
    required this.mqttClients,
    required this.lastUpdate,
  });

  PmsServer copyWith({
    bool? heartbeat,
    int? mqttClients,
    int? lastUpdate,
  }) =>
      PmsServer(
        heartbeat: heartbeat ?? this.heartbeat,
        mqttClients: mqttClients ?? this.mqttClients,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );

  factory PmsServer.fromRawJson(String str) => PmsServer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PmsServer.fromJson(Map<String, dynamic> json) => PmsServer(
    heartbeat: json["heartbeat"],
    mqttClients: json["mqtt_clients"],
    lastUpdate: json["last_update"],
  );

  Map<String, dynamic> toJson() => {
    "heartbeat": heartbeat,
    "mqtt_clients": mqttClients,
    "last_update": lastUpdate,
  };
}

class Port {
  String name;
  String imageUri;
  List<dynamic> meters;
  PortStatus status;
  PortFeedback feedback;
  Alarms alarms;

  Port({
    required this.name,
    required this.imageUri,
    required this.meters,
    required this.status,
    required this.feedback,
    required this.alarms,
  });

  Port copyWith({
    String? name,
    String? imageUri,
    List<dynamic>? meters,
    PortStatus? status,
    PortFeedback? feedback,
    Alarms? alarms,
  }) =>
      Port(
        name: name ?? this.name,
        imageUri: imageUri ?? this.imageUri,
        meters: meters ?? this.meters,
        status: status ?? this.status,
        feedback: feedback ?? this.feedback,
        alarms: alarms ?? this.alarms,
      );

  factory Port.fromRawJson(String str) => Port.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Port.fromJson(Map<String, dynamic> json) => Port(
    name: json["name"],
    imageUri: json["image_uri"],
    meters: List<dynamic>.from(json["meters"].map((x) => x)),
    status: PortStatus.fromJson(json["status"]),
    feedback: PortFeedback.fromJson(json["feedback"]),
    alarms: Alarms.fromJson(json["alarms"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image_uri": imageUri,
    "meters": List<dynamic>.from(meters.map((x) => x)),
    "status": status.toJson(),
    "feedback": feedback.toJson(),
    "alarms": alarms.toJson(),
  };
}

class Alarms {
  bool buzzer;
  bool lowVoltage;
  bool highVoltate;
  bool highCurrent;
  bool fluctuation;
  bool wiringVoltate;
  bool wiringCurrent;
  bool waitingAlarm;
  bool thyristorPower;

  Alarms({
    required this.buzzer,
    required this.lowVoltage,
    required this.highVoltate,
    required this.highCurrent,
    required this.fluctuation,
    required this.wiringVoltate,
    required this.wiringCurrent,
    required this.waitingAlarm,
    required this.thyristorPower,
  });

  Alarms copyWith({
    bool? buzzer,
    bool? lowVoltage,
    bool? highVoltate,
    bool? highCurrent,
    bool? fluctuation,
    bool? wiringVoltate,
    bool? wiringCurrent,
    bool? waitingAlarm,
    bool? thyristorPower,
  }) =>
      Alarms(
        buzzer: buzzer ?? this.buzzer,
        lowVoltage: lowVoltage ?? this.lowVoltage,
        highVoltate: highVoltate ?? this.highVoltate,
        highCurrent: highCurrent ?? this.highCurrent,
        fluctuation: fluctuation ?? this.fluctuation,
        wiringVoltate: wiringVoltate ?? this.wiringVoltate,
        wiringCurrent: wiringCurrent ?? this.wiringCurrent,
        waitingAlarm: waitingAlarm ?? this.waitingAlarm,
        thyristorPower: thyristorPower ?? this.thyristorPower,
      );

  factory Alarms.fromRawJson(String str) => Alarms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alarms.fromJson(Map<String, dynamic> json) => Alarms(
    buzzer: json["buzzer"],
    lowVoltage: json["low_voltage"],
    highVoltate: json["high_voltate"],
    highCurrent: json["high_current"],
    fluctuation: json["fluctuation"],
    wiringVoltate: json["wiring_voltate"],
    wiringCurrent: json["wiring_current"],
    waitingAlarm: json["waiting_alarm"],
    thyristorPower: json["thyristor_power"],
  );

  Map<String, dynamic> toJson() => {
    "buzzer": buzzer,
    "low_voltage": lowVoltage,
    "high_voltate": highVoltate,
    "high_current": highCurrent,
    "fluctuation": fluctuation,
    "wiring_voltate": wiringVoltate,
    "wiring_current": wiringCurrent,
    "waiting_alarm": waitingAlarm,
    "thyristor_power": thyristorPower,
  };
}

class PortFeedback {
  bool breaker;
  bool contactor;
  bool thyristorGate;
  bool thyristorPowerTemp;

  PortFeedback({
    required this.breaker,
    required this.contactor,
    required this.thyristorGate,
    required this.thyristorPowerTemp,
  });

  PortFeedback copyWith({
    bool? breaker,
    bool? contactor,
    bool? thyristorGate,
    bool? thyristorPowerTemp,
  }) =>
      PortFeedback(
        breaker: breaker ?? this.breaker,
        contactor: contactor ?? this.contactor,
        thyristorGate: thyristorGate ?? this.thyristorGate,
        thyristorPowerTemp: thyristorPowerTemp ?? this.thyristorPowerTemp,
      );

  factory PortFeedback.fromRawJson(String str) => PortFeedback.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PortFeedback.fromJson(Map<String, dynamic> json) => PortFeedback(
    breaker: json["breaker"],
    contactor: json["contactor"],
    thyristorGate: json["thyristor_gate"],
    thyristorPowerTemp: json["thyristor_power_temp"],
  );

  Map<String, dynamic> toJson() => {
    "breaker": breaker,
    "contactor": contactor,
    "thyristor_gate": thyristorGate,
    "thyristor_power_temp": thyristorPowerTemp,
  };
}

class PortStatus {
  bool online;
  bool tripped;
  bool contactorRelay;
  bool thyristor;
  bool autoStartSecuence;
  bool autoStopSecuence;
  bool autoStartPreheat;

  PortStatus({
    required this.online,
    required this.tripped,
    required this.contactorRelay,
    required this.thyristor,
    required this.autoStartSecuence,
    required this.autoStopSecuence,
    required this.autoStartPreheat,
  });

  PortStatus copyWith({
    bool? online,
    bool? tripped,
    bool? contactorRelay,
    bool? thyristor,
    bool? autoStartSecuence,
    bool? autoStopSecuence,
    bool? autoStartPreheat,
  }) =>
      PortStatus(
        online: online ?? this.online,
        tripped: tripped ?? this.tripped,
        contactorRelay: contactorRelay ?? this.contactorRelay,
        thyristor: thyristor ?? this.thyristor,
        autoStartSecuence: autoStartSecuence ?? this.autoStartSecuence,
        autoStopSecuence: autoStopSecuence ?? this.autoStopSecuence,
        autoStartPreheat: autoStartPreheat ?? this.autoStartPreheat,
      );

  factory PortStatus.fromRawJson(String str) => PortStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PortStatus.fromJson(Map<String, dynamic> json) => PortStatus(
    online: json["online"],
    tripped: json["tripped"],
    contactorRelay: json["contactor_relay"],
    thyristor: json["thyristor"],
    autoStartSecuence: json["auto_start_secuence"],
    autoStopSecuence: json["auto_stop_secuence"],
    autoStartPreheat: json["auto_start_preheat"],
  );

  Map<String, dynamic> toJson() => {
    "online": online,
    "tripped": tripped,
    "contactor_relay": contactorRelay,
    "thyristor": thyristor,
    "auto_start_secuence": autoStartSecuence,
    "auto_stop_secuence": autoStopSecuence,
    "auto_start_preheat": autoStartPreheat,
  };
}

class Serial {
  bool heartbeat;
  bool wiresReversed;
  String fill;
  String shape;
  String text;
  Source source;

  Serial({
    required this.heartbeat,
    required this.wiresReversed,
    required this.fill,
    required this.shape,
    required this.text,
    required this.source,
  });

  Serial copyWith({
    bool? heartbeat,
    bool? wiresReversed,
    String? fill,
    String? shape,
    String? text,
    Source? source,
  }) =>
      Serial(
        heartbeat: heartbeat ?? this.heartbeat,
        wiresReversed: wiresReversed ?? this.wiresReversed,
        fill: fill ?? this.fill,
        shape: shape ?? this.shape,
        text: text ?? this.text,
        source: source ?? this.source,
      );

  factory Serial.fromRawJson(String str) => Serial.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Serial.fromJson(Map<String, dynamic> json) => Serial(
    heartbeat: json["heartbeat"],
    wiresReversed: json["wires_reversed"],
    fill: json["fill"],
    shape: json["shape"],
    text: json["text"],
    source: Source.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "heartbeat": heartbeat,
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

class Shore {
  String name;
  String imageUri;
  List<dynamic> meters;
  ShoreAStatus status;
  PortFeedback feedback;
  Alarms alarms;

  Shore({
    required this.name,
    required this.imageUri,
    required this.meters,
    required this.status,
    required this.feedback,
    required this.alarms,
  });

  Shore copyWith({
    String? name,
    String? imageUri,
    List<dynamic>? meters,
    ShoreAStatus? status,
    PortFeedback? feedback,
    Alarms? alarms,
  }) =>
      Shore(
        name: name ?? this.name,
        imageUri: imageUri ?? this.imageUri,
        meters: meters ?? this.meters,
        status: status ?? this.status,
        feedback: feedback ?? this.feedback,
        alarms: alarms ?? this.alarms,
      );

  factory Shore.fromRawJson(String str) => Shore.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shore.fromJson(Map<String, dynamic> json) => Shore(
    name: json["name"],
    imageUri: json["image_uri"],
    meters: List<dynamic>.from(json["meters"].map((x) => x)),
    status: ShoreAStatus.fromJson(json["status"]),
    feedback: PortFeedback.fromJson(json["feedback"]),
    alarms: Alarms.fromJson(json["alarms"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image_uri": imageUri,
    "meters": List<dynamic>.from(meters.map((x) => x)),
    "status": status.toJson(),
    "feedback": feedback.toJson(),
    "alarms": alarms.toJson(),
  };
}

class ShoreAStatus {
  bool online;
  bool precense;
  bool tripped;
  bool contactorRelay;
  bool thyristor;

  ShoreAStatus({
    required this.online,
    required this.precense,
    required this.tripped,
    required this.contactorRelay,
    required this.thyristor,
  });

  ShoreAStatus copyWith({
    bool? online,
    bool? precense,
    bool? tripped,
    bool? contactorRelay,
    bool? thyristor,
  }) =>
      ShoreAStatus(
        online: online ?? this.online,
        precense: precense ?? this.precense,
        tripped: tripped ?? this.tripped,
        contactorRelay: contactorRelay ?? this.contactorRelay,
        thyristor: thyristor ?? this.thyristor,
      );

  factory ShoreAStatus.fromRawJson(String str) => ShoreAStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShoreAStatus.fromJson(Map<String, dynamic> json) => ShoreAStatus(
    online: json["online"],
    precense: json["precense"],
    tripped: json["tripped"],
    contactorRelay: json["contactor_relay"],
    thyristor: json["thyristor"],
  );

  Map<String, dynamic> toJson() => {
    "online": online,
    "precense": precense,
    "tripped": tripped,
    "contactor_relay": contactorRelay,
    "thyristor": thyristor,
  };
}

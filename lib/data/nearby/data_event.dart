class SentEvent {
  final String actionType;
  final dynamic data;

  SentEvent(this.actionType, this.data);

  Map<String, dynamic> toJson() =>
      {"actionType": actionType.toString(), "data": data};

  factory SentEvent.fromJson(Map<String, dynamic> json) =>
      SentEvent(json['actionType'], json['data']);
}

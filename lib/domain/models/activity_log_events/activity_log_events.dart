class ActivityLogEvents {
  int? status;
  List<ActivityLogEvent>? data;

  ActivityLogEvents(this.status, this.data);
}

class ActivityLogEvent {
  String? event;

  ActivityLogEvent(this.event);
}

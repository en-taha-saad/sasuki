// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'activity_log_events_responses.g.dart';

@JsonSerializable()
class ActivityLogEventsResponses {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'data')
  List<ActivityLogEventResponse>? data;

  ActivityLogEventsResponses(this.status, this.data);
  factory ActivityLogEventsResponses.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogEventsResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityLogEventsResponsesToJson(this);
}

@JsonSerializable()
class ActivityLogEventResponse {
  @JsonKey(name: 'event')
  String? event;

  ActivityLogEventResponse(this.event);
  factory ActivityLogEventResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogEventResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityLogEventResponseToJson(this);
}

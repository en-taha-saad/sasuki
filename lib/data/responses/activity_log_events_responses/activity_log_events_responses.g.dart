// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log_events_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLogEventsResponses _$ActivityLogEventsResponsesFromJson(
        Map<String, dynamic> json) =>
    ActivityLogEventsResponses(
      json['status'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ActivityLogEventResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActivityLogEventsResponsesToJson(
        ActivityLogEventsResponses instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

ActivityLogEventResponse _$ActivityLogEventResponseFromJson(
        Map<String, dynamic> json) =>
    ActivityLogEventResponse(
      json['event'] as String?,
    );

Map<String, dynamic> _$ActivityLogEventResponseToJson(
        ActivityLogEventResponse instance) =>
    <String, dynamic>{
      'event': instance.event,
    };

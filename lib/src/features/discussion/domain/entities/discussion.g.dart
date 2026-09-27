// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discussion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Discussion _$DiscussionFromJson(Map<String, dynamic> json) => _Discussion(
  discussionId: (json['discussion_id'] as num?)?.toInt(),
  topic: json['topic'] as String?,
  authorId: json['author_id'] as String?,
  createdAt: _$JsonConverterFromJson<String, DateTime>(
    json['created_at'],
    const DateTimeJsonConverter().fromJson,
  ),
  activeMemberCount: (json['active_member_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$DiscussionToJson(_Discussion instance) =>
    <String, dynamic>{
      'discussion_id': ?instance.discussionId,
      'topic': ?instance.topic,
      'author_id': instance.authorId,
      'created_at': ?_$JsonConverterToJson<String, DateTime>(
        instance.createdAt,
        const DateTimeJsonConverter().toJson,
      ),
      'active_member_count': ?instance.activeMemberCount,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ServerTimestampConverter implements JsonConverter<DateTime?, Object?> {
  const ServerTimestampConverter();

  @override
  DateTime? fromJson(Object? timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else {
      return null;
    }
  }

  @override
  Object? toJson(DateTime? date) => date != null ? FieldValue.serverTimestamp() : null;
}

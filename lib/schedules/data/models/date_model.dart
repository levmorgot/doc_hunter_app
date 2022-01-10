import 'package:doc_hunter_app/schedules/domain/entities/date_entity.dart';

class DateModel extends DateEntity {
  const DateModel({required date, required startInterval, required endInterval})
      : super(
            date: date, startInterval: startInterval, endInterval: endInterval);

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      date: json['date'],
      startInterval: json['startInterval'] ?? '',
      endInterval: json['endInterval']  ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'startInterval': startInterval,
      'endInterval': endInterval,
    };
  }
}

import 'package:doc_hunter_app/schedules/domain/entities/date_entity.dart';

class DateModel extends DateEntity {
  const DateModel({required date}) : super(date: date);

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'date': date};
  }
}

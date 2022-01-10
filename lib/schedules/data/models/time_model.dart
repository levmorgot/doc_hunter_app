import 'package:doc_hunter_app/schedules/domain/entities/time_entity.dart';

class TimeModel extends TimeEntity {
  const TimeModel({required time, required isFree})
      : super(time: time, isFree: isFree);

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      time: json['time'],
      isFree: json['isFree'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'time': time, 'isFree': isFree};
  }
}

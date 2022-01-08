import 'package:doc_hunter_app/schedules/domain/entities/time_entity.dart';

class TimeModel extends TimeEntity {
  const TimeModel({required time}) : super(time: time);

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'time': time};
  }
}

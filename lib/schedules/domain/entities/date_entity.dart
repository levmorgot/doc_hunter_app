import 'package:equatable/equatable.dart';

class DateEntity extends Equatable {
  final String date;

  const DateEntity({
    required this.date,
  });

  @override
  List<Object?> get props => [date];
}

import 'package:equatable/equatable.dart';

class PageDepartmentParams extends Equatable {
  final int limit;
  final int skip;

  const PageDepartmentParams({
    required this.limit,
    required this.skip,
  });


  @override
  List<Object?> get props => [limit, skip];
}
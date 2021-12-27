import 'package:equatable/equatable.dart';

class PageFilialParams extends Equatable {
  final int limit;
  final int skip;

  const PageFilialParams({
    required this.limit,
    required this.skip,
  });


  @override
  List<Object?> get props => [limit, skip];
}
import 'package:equatable/equatable.dart';

class PageDoctorParams extends Equatable {
  final int filiaId;
  final int filialCacheId;
  final int limit;
  final int skip;

  const PageDoctorParams({
    required this.filiaId,
    required this.filialCacheId,
    required this.limit,
    required this.skip,
  });


  @override
  List<Object?> get props => [filiaId, filialCacheId, limit, skip];
}
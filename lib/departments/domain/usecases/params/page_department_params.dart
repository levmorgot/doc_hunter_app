import 'package:equatable/equatable.dart';

class PageDepartmentParams extends Equatable {
  final int filiaId;
  final int filialCacheId;
  final int limit;
  final int skip;

  const PageDepartmentParams({
    required this.filiaId,
    required this.filialCacheId,
    required this.limit,
    required this.skip,
  });


  @override
  List<Object?> get props => [filiaId, filialCacheId, limit, skip];
}
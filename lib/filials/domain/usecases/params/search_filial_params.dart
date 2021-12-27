import 'package:doc_hunter_app/filials/domain/usecases/params/page_filial_params.dart';
import 'package:equatable/equatable.dart';

class SearchFilialParams extends Equatable {
  final PageFilialParams pageParams;
  final String query;

  const SearchFilialParams({
    required this.pageParams,
    required this.query,
  });


  @override
  List<Object?> get props => [pageParams, query];
}
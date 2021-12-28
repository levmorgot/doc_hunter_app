import 'package:doc_hunter_app/filials/domain/usecases/params/page_filial_params.dart';
import 'package:equatable/equatable.dart';

abstract class FilialSearchEvent extends Equatable {
  const FilialSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchFilialsEvent extends FilialSearchEvent {
  final String filialQuery;
  final PageFilialParams pageFilialParams;

  const SearchFilialsEvent(this.filialQuery, this.pageFilialParams);
}
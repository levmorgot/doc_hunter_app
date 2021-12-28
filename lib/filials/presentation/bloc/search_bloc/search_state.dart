import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FilialSearchState extends Equatable {
 const FilialSearchState();

  @override
  List<Object> get props => [];
}

class FilialSearchEmptyState extends FilialSearchState {}

class FilialSearchLoadingState extends FilialSearchState {}

class FilialSearchLoadedState extends FilialSearchState {
  final List<FilialEntity> filials;

  const FilialSearchLoadedState({required this.filials});

  @override
  List<Object> get props => [filials];
}

class FilialSearchErrorState extends FilialSearchState {
  final String message;

  const FilialSearchErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
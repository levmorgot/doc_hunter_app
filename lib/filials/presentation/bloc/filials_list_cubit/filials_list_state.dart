import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FilialState extends Equatable {
  const FilialState();

  @override
  List<Object> get props => [];
}

class FilialEmptyState extends FilialState {
  @override
  List<Object> get props => [];
}

class FilialLoadingState extends FilialState {
  final List<FilialEntity> oldFilialsList;
  final bool isFirstFetch;

  const FilialLoadingState(this.oldFilialsList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldFilialsList];
}


class FilialLoadedState extends FilialState {
  final List<FilialEntity> filialsList;
  final bool thatAll;

  const FilialLoadedState(this.filialsList, this.thatAll);

  @override
  List<Object> get props => [filialsList];
}

class FilialErrorState extends FilialState {
  final String message;

  const FilialErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
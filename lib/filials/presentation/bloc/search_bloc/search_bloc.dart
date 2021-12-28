import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/filials/domain/usecases/params/search_filial_params.dart';
import 'package:doc_hunter_app/filials/domain/usecases/search_filial.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_event.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilialSearchBloc extends Bloc<FilialSearchEvent, FilialSearchState> {
  final SearchFilial searchFilial;

  FilialSearchBloc({required this.searchFilial})
      : super(FilialSearchEmptyState()) {
    on<SearchFilialsEvent>((event, emit) async {
      emit(FilialSearchLoadingState());
      final failureOrFilials = await searchFilial(SearchFilialParams(pageParams: event.pageFilialParams, query: event.filialQuery));

      failureOrFilials.fold((failure) {
        emit(FilialSearchErrorState(message: _mapFailureMessage(failure)));
      }, (filials) {
        emit(FilialSearchLoadedState(filials: filials));
      });
    });
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected Error';
    }
  }
}

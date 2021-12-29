import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';
import 'package:doc_hunter_app/filials/domain/usecases/get_all_filials.dart';
import 'package:doc_hunter_app/filials/domain/usecases/params/page_filial_params.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/filials_list_cubit/filials_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilialsListCubit extends Cubit<FilialState> {
  final GetAllFilials getAllFilials;
  final int limit;

  FilialsListCubit({required this.getAllFilials, required this.limit})
      : super(FilialEmptyState());
  int skip = 0;

  void loadFilials() async {
    if (state is FilialLoadingState) return;

    final currentState = state;

    var oldFilials = <FilialEntity>[];
    if (currentState is FilialLoadedState) {
      oldFilials = currentState.filialsList;
    }

    emit(FilialLoadingState(oldFilials, isFirstFetch: skip == 0));

    final failureOrFilials =
        await getAllFilials(PageFilialParams(skip: skip, limit: limit));

    failureOrFilials.fold(
        (failure) =>
            emit(FilialErrorState(message: _mapFailureMessage(failure))),
        (filial) {
      skip += limit;
      final filials = (state as FilialLoadingState).oldFilialsList;
      filials.addAll(filial);
      emit(FilialLoadedState(filials));
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

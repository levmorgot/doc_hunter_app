import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/common/widgets/doc_progress_indicator.dart';
import 'package:doc_hunter_app/common/widgets/error_search_text.dart';
import 'package:doc_hunter_app/common/widgets/suggestion.dart';
import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';
import 'package:doc_hunter_app/doctors/domain/usecases/params/page_doctor_params.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/search_bloc/search_event.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/search_bloc/search_state.dart';
import 'package:doc_hunter_app/doctors/presentation/widgets/doctors_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSearchDelegate extends SearchDelegate {
  final int filialId;
  final int filialCacheId;
  final int departmentId;
  final _suggestions = [
    'Власенко',
    'Петрова ',
    'Елена',
    'Сергеевна',
  ];

  DoctorSearchDelegate(
      {required this.filialId,
      required this.filialCacheId,
      required this.departmentId})
      : super(searchFieldLabel: 'Поиск по больницам');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        tooltip: 'Назад',
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<DoctorSearchBloc>(context, listen: false).add(
        SearchDoctorsEvent(
            query,
            PageDoctorParams(
                limit: 15,
                skip: 0,
                filialCacheId: filialCacheId,
                filiaId: filialId,
                departmentId: departmentId)));
    return BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
        builder: (context, state) {
      if (state is DoctorSearchLoadingState) {
        return const Center(
          child: DocProgressIndicator(),
        );
      } else if (state is DoctorSearchLoadedState) {
        final doctors = state.doctors;
        if (doctors.isEmpty) {
          return _showErrorText('По вашему запросу ничего не найдено');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: doctors.isNotEmpty ? doctors.length : 0,
          itemBuilder: (context, index) {
            DoctorEntity result = doctors[index];
            return DoctorCard(
              doctor: result,
              filialId: filialId,
              departmentId: departmentId,
              filialCacheId: filialCacheId,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: AppColors.cardDivider,
            );
          },
        );
      } else if (state is DoctorSearchErrorState) {
        return _showErrorText(state.message);
      } else {
        return const Center(
          child: Icon(Icons.now_wallpaper),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Suggestion(
          onTap: () {
            query = _suggestions[index];
          },
          suggestion: _suggestions[index],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: _suggestions.length,
    );
  }

  Widget _showErrorText(String errorMessage) {
    return ErrorSearchText(
      errorMessage: errorMessage,
    );
  }
}

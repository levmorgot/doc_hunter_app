import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/common/widgets/doc_progress_indicator.dart';
import 'package:doc_hunter_app/common/widgets/error_search_text.dart';
import 'package:doc_hunter_app/common/widgets/suggestion.dart';
import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:doc_hunter_app/departments/domain/usecases/params/page_department_params.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/search_bloc/search_event.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/search_bloc/search_state.dart';
import 'package:doc_hunter_app/departments/presentation/widgets/departments_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentSearchDelegate extends SearchDelegate {
  final int filialId;
  final int filialCacheId;
  final _suggestions = [
    'Травмотология',
    'Терапия ',
    'Стоматология',
    'Офтальмология',
  ];

  DepartmentSearchDelegate(
      {required this.filialId, required this.filialCacheId})
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
    BlocProvider.of<DepartmentSearchBloc>(context, listen: false).add(
        SearchDepartmentsEvent(
            query,
            PageDepartmentParams(
                limit: 15,
                skip: 0,
                filialCacheId: filialCacheId,
                filiaId: filialId)));
    return BlocBuilder<DepartmentSearchBloc, DepartmentSearchState>(
        builder: (context, state) {
      if (state is DepartmentSearchLoadingState) {
        return const Center(
          child: DocProgressIndicator(),
        );
      } else if (state is DepartmentSearchLoadedState) {
        final departments = state.departments;
        if (departments.isEmpty) {
          return _showErrorText('По вашему запросу ничего не найдено');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: departments.isNotEmpty ? departments.length : 0,
          itemBuilder: (context, index) {
            DepartmentEntity result = departments[index];
            return DepartmentCard(
              department: result,
              filialCacheId: filialCacheId,
              filialId: filialId,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: AppColors.cardDivider,
            );
          },
        );
      } else if (state is DepartmentSearchErrorState) {
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

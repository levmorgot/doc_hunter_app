import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/common/widgets/doc_progress_indicator.dart';
import 'package:doc_hunter_app/common/widgets/error_search_text.dart';
import 'package:doc_hunter_app/common/widgets/suggestion.dart';
import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';
import 'package:doc_hunter_app/filials/domain/usecases/params/page_filial_params.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_event.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_state.dart';
import 'package:doc_hunter_app/filials/presentation/widgets/filials_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilialSearchDelegate extends SearchDelegate {
  final _suggestions = [
    'Мира',
    'Детская ',
    'Стоматология',
    'Михайловская',
  ];

  FilialSearchDelegate() : super(searchFieldLabel: 'Поиск по больницам');

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
    BlocProvider.of<FilialSearchBloc>(context, listen: false).add(
        SearchFilialsEvent(query, const PageFilialParams(limit: 15, skip: 0)));
    return BlocBuilder<FilialSearchBloc, FilialSearchState>(
        builder: (context, state) {
      if (state is FilialSearchLoadingState) {
        return const Center(
          child: DocProgressIndicator(),
        );
      } else if (state is FilialSearchLoadedState) {
        final filials = state.filials;
        if (filials.isEmpty) {
          return _showErrorText('По вашему запросу ничего не найдено');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: filials.isNotEmpty ? filials.length : 0,
          itemBuilder: (context, index) {
            FilialEntity result = filials[index];
            return FilialCard(filial: result);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: AppColors.cardDivider,
            );
          },
        );
      } else if (state is FilialSearchErrorState) {
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

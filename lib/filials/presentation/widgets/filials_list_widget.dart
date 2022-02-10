import 'dart:async';

import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/common/widgets/doc_progress_indicator.dart';
import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/filials_list_cubit/filials_list_cubit.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/filials_list_cubit/filials_list_state.dart';
import 'package:doc_hunter_app/filials/presentation/widgets/filials_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilialsList extends StatelessWidget {
  final scrollController = ScrollController();

  FilialsList({Key? key}) : super(key: key);

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<FilialsListCubit>().loadFilials();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    bool isLoading = false;

    return BlocBuilder<FilialsListCubit, FilialState>(
        builder: (context, state) {
      List<FilialEntity> filials = [];
      bool thatAll = false;
      if (state is FilialLoadingState && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is FilialLoadingState) {
        filials = state.oldFilialsList;
        isLoading = true;
      } else if (state is FilialErrorState) {
        return Text(state.message);
      } else if (state is FilialLoadedState) {
        filials = state.filialsList;
        thatAll = state.thatAll;
      }
      return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < filials.length) {
            return FilialCard(filial: filials[index]);
          } else {
            Timer(const Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: AppColors.cardDivider,
          );
        },
        itemCount: filials.length + (isLoading && !thatAll ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: DocProgressIndicator(),
      ),
    );
  }
}

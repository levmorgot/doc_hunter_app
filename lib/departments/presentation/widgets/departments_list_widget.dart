import 'dart:async';

import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/common/widgets/doc_progress_indicator.dart';
import 'package:doc_hunter_app/common/widgets/empty_message.dart';

import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/departments_list_cubit/departments_list_cubit.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/departments_list_cubit/departments_list_state.dart';
import 'package:doc_hunter_app/departments/presentation/widgets/departments_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentsList extends StatelessWidget {
  final scrollController = ScrollController();
  final int filialId;
  final int filialCacheId;

  DepartmentsList({
    Key? key,
    required this.filialId,
    required this.filialCacheId,
  }) : super(key: key);

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context
              .read<DepartmentsListCubit>()
              .loadDepartments(filialId, filialCacheId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    bool isLoading = false;
    context
        .read<DepartmentsListCubit>()
        .loadDepartments(filialId, filialCacheId);
    return BlocBuilder<DepartmentsListCubit, DepartmentState>(
        builder: (context, state) {
      List<DepartmentEntity> departments = [];
      bool thatAll = false;

      if (state is DepartmentLoadingState && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is DepartmentLoadingState) {
        departments = state.oldDepartments["$filialId-$filialCacheId"] ?? [];
        isLoading = true;
      } else if (state is DepartmentErrorState) {
        return Text(state.message);
      } else if (state is DepartmentEmptyState) {
        return const EmptyMessage(
            message:
                "Нам очень жаль, но эта больница не подключена к сервису электронной регистратуры");
      } else if (state is DepartmentLoadedState) {
        departments = state.departmentsList["$filialId-$filialCacheId"] ?? [];
        thatAll = state.thatAll;
      }
      return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < departments.length) {
            return DepartmentCard(
              department: departments[index],
              filialCacheId: filialCacheId,
              filialId: filialId,
            );
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
        itemCount: departments.length + (isLoading && !thatAll ? 1 : 0),
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

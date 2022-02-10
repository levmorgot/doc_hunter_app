import 'dart:async';

import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/common/widgets/doc_progress_indicator.dart';
import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/doctors_list_cubit/doctors_list_cubit.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/doctors_list_cubit/doctors_list_state.dart';
import 'package:doc_hunter_app/doctors/presentation/widgets/doctors_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsList extends StatelessWidget {
  final scrollController = ScrollController();
  final int filialId;
  final int filialCacheId;
  final int departmentId;

  DoctorsList(
      {Key? key,
      required this.filialId,
      required this.filialCacheId,
      required this.departmentId})
      : super(key: key);

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context
              .read<DoctorsListCubit>()
              .loadDoctors(filialId, filialCacheId, departmentId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    bool isLoading = false;
    context
        .read<DoctorsListCubit>()
        .loadDoctors(filialId, filialCacheId, departmentId);
    return BlocBuilder<DoctorsListCubit, DoctorState>(
        builder: (context, state) {
      List<DoctorEntity> doctors = [];
      bool thatAll = false;

      if (state is DoctorLoadingState && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is DoctorLoadingState) {
        doctors =
            state.oldDoctors["$filialId-$filialCacheId-$departmentId"] ?? [];
        isLoading = true;
      } else if (state is DoctorErrorState) {
        return Text(state.message);
      } else if (state is DoctorEmptyState) {
        return const Text("Нет отделений");
      } else if (state is DoctorLoadedState) {
        doctors =
            state.doctorsList["$filialId-$filialCacheId-$departmentId"] ?? [];
        thatAll = state.thatAll;
      }
      return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < doctors.length) {
            return DoctorCard(
              doctor: doctors[index],
              filialId: filialId,
              departmentId: departmentId,
              filialCacheId: filialCacheId,
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
        itemCount: doctors.length + (isLoading && !thatAll ? 1 : 0),
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

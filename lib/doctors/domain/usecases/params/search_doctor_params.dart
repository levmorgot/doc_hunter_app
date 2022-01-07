import 'package:doc_hunter_app/doctors/domain/usecases/params/page_doctor_params.dart';
import 'package:equatable/equatable.dart';

class SearchDoctorParams extends Equatable {
  final PageDoctorParams pageParams;
  final String query;

  const SearchDoctorParams({
    required this.pageParams,
    required this.query,
  });


  @override
  List<Object?> get props => [pageParams, query];
}
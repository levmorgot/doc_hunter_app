import 'package:doc_hunter_app/doctors/domain/usecases/params/page_doctor_params.dart';
import 'package:equatable/equatable.dart';

abstract class DoctorSearchEvent extends Equatable {
  const DoctorSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchDoctorsEvent extends DoctorSearchEvent {
  final String doctorQuery;
  final PageDoctorParams pageDoctorParams;

  const SearchDoctorsEvent(this.doctorQuery, this.pageDoctorParams);
}
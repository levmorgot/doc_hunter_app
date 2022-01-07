import 'package:doc_hunter_app/doctors/presentation/widgets/doctors_list_widget.dart';
import 'package:doc_hunter_app/doctors/presentation/widgets/doctors_search_delegate.dart';
import 'package:flutter/material.dart';

class DoctorsPage extends StatelessWidget {
  final int filialId;
  final int filialCacheId;
  final int departmentId;

  const DoctorsPage(
      {Key? key, required this.filialId, required this.filialCacheId, required this.departmentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список врачей'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: DoctorSearchDelegate(filialId: filialId, filialCacheId: filialCacheId, departmentId: departmentId));
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          )
        ],
      ),
      body: DoctorsList(filialId: filialId, filialCacheId: filialCacheId, departmentId: departmentId,),
    );
  }
}

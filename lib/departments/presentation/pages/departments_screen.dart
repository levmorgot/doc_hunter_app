import 'package:doc_hunter_app/departments/presentation/widgets/departments_list_widget.dart';
import 'package:doc_hunter_app/departments/presentation/widgets/departments_search_delegate.dart';
import 'package:flutter/material.dart';

class DepartmentsPage extends StatelessWidget {
  final int filialId;
  final int filialCacheId;

  const DepartmentsPage(
      {Key? key, required this.filialId, required this.filialCacheId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список отделений'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: DepartmentSearchDelegate(filialId: filialId, filialCacheId: filialCacheId));
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          )
        ],
      ),
      body: DepartmentsList(filialId: filialId, filialCacheId: filialCacheId),
    );
  }
}

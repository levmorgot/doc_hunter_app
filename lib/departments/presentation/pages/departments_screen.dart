import 'package:doc_hunter_app/departments/presentation/widgets/department_search_delegate.dart';
import 'package:doc_hunter_app/departments/presentation/widgets/departments_list_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список больниц'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: DepartmentSearchDelegate());
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          )
        ],
      ),
      body: DepartmentsList(),
    );
  }
}

import 'package:doc_hunter_app/common/widgets/search_icon.dart';
import 'package:doc_hunter_app/filials/presentation/widgets/filial_search_delegate.dart';
import 'package:doc_hunter_app/filials/presentation/widgets/filials_list_widget.dart';
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
          SearchIcon(
            onPressed: () {
              showSearch(
                context: context,
                delegate: FilialSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: FilialsList(),
    );
  }
}

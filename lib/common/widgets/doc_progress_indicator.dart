import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:flutter/material.dart';

class DocProgressIndicator extends StatelessWidget {
  const DocProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: AppColors.progressIndicator,
    );
  }
}

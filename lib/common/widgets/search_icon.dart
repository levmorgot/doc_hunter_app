import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:flutter/material.dart';

class SearchIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const SearchIcon({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.search),
      color: AppColors.searchIcon,
    );
  }
}

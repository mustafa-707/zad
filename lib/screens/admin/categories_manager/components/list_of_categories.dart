import 'package:flutter/material.dart';
import 'package:zad_app/models/category.dart';
import 'package:zad_app/screens/admin/categories_manager/components/category.dart';
import 'package:zad_app/utils/theme/images.dart';

class ListOfCategories extends StatelessWidget {
  final List<DawaCategory> data;

  const ListOfCategories({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? Images.notFound
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return CategoryAdminWidget(
                  data: data[index],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 174,
              ),
            ),
          );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/shimmers/categories_shimmer.dart';
import 'package:glaz/hooks/fetch_categories.dart';
import 'package:glaz/models/categories.dart';
import 'category_widget.dart';

class CategoryList extends HookWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCategories();
    List<CategoriesModel>? categoriesList = hookResult.data;
    final isloading = hookResult.isLoading;
    final error = hookResult.error;

    return Container(
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: isloading
          ? const CatergoriesShimmer()
          : categoriesList != null
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categoriesList!.length, (i) {
                      CategoriesModel category = categoriesList![i];
                      return CategoryWidget(category: category);
                    }),
                  ),
                )
              : Container(), // Vous pouvez également afficher un widget vide ou un message d'attente selon vos besoins.
    );
  }
}*/

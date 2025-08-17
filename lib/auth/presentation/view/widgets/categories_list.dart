import 'package:flutter/material.dart';
import 'package:uber/auth/presentation/view/widgets/category_card.dart';

import '../../../data/models/category_model.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final List<CategoryModel> categories = [];

  @override
  Widget build(BuildContext context) {
    categories.sort((a, b) => a.name.compareTo(b.name));

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                for (int i = 0; i < categories.length; i++) {
                  categories[i].hasCliced = (i == index);
                }
              });
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: CategoriesCard(
              title: categories[index].name.split('-')[1],
              isCheck: categories[index].hasCliced,
              icon: categories[index].icon,
            ),
          ),
        ),
      ),
    );
  }
}

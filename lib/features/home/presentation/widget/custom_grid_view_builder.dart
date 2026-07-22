import 'package:flutter/material.dart';

import '../../../../core/model/product_model.dart';
import '../../../../core/router/contents_router.dart';
import 'custom_grid_item.dart';

class CustomGridViewBuilder extends StatelessWidget {
  const CustomGridViewBuilder({
    super.key,
    required this.products,
    this.physics,
  });

  final List<ProductEntity> products;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: physics,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 25,
        crossAxisSpacing: 15,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ContentsRouter.detailsCard,
              arguments: product,
            );
          },
          child: CustomGridItem(product: product),
        );
      },
    );
  }
}

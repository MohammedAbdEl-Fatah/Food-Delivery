import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/core/utils/helper/format_price.dart';
import 'package:food_delivery/features/home/presentation/cubit/price/price.cubit.dart';
import 'package:food_delivery/features/home/presentation/widget/botton_bar_detail_card.dart';

import '../../../../core/widget/loading.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({super.key});

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  bool islove = false;
  @override
  Widget build(BuildContext context) {
    final ProductEntity product =
        ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return BlocProvider(
      create: (context) => PriceCubit(price: product.price as int),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            //app bar
            SliverAppBar(
              expandedHeight: MediaQuery.sizeOf(context).height * 0.36,
              pinned: true,
              backgroundColor: ColorManager.white,
              leading: BackButton(
                onPressed: () => Navigator.pop(context),
                color: ColorManager.white,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      //make it red or white
                      islove = !islove;
                      setState(() {});
                    },
                    child: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: islove ? ColorManager.error : ColorManager.white,
                    ),
                  ),
                ),
              ],
              //add animation hero
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: product.urlImage!,
                  fadeInDuration: const Duration(milliseconds: 300),
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: Loading()),
                  errorWidget:
                      (context, url, error) => const Icon(Icons.broken_image),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.008),
                    _header(title: product.title),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.008),
                    _price(price: product.price as int),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.016),
                    _detailsWork(
                      context,
                      avgCookingTime: product.avgCookingTime,
                      rating: product.rating,
                      isDelivered: product.isDelivered,
                      priceDelivery: product.priceDelivery as int,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.032),
                    _description(description: product.description),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.032),

                    // Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottonBarDetailCard(product: product),
      ),
    );
  }

  Widget _header({required String title}) {
    return Text(title, style: AppTextStyle.header4, textAlign: TextAlign.start);
  }

  Widget _price({required int price}) {
    return Text(
      "\$ ${price.withComma} /Piece",
      style: AppTextStyle.header5.copyWith(
        color: ColorManager.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _detailsWork(
    BuildContext context, {
    required List<dynamic> avgCookingTime,
    required num rating,
    required bool isDelivered,
    required int priceDelivery,
  }) {
    final double iconSize = 18;
    final Color iconColor = ColorManager.primary;
    final TextStyle textStyle = TextStyle(
      color: ColorManager.grey,
      fontSize: AppTextStyle.bodyMedium.fontSize, // reuse font size if needed
      fontWeight: AppTextStyle.bodyMedium.fontWeight,
    );

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.04,
      decoration: BoxDecoration(
        color: ColorManager.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(22.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          // Free Delivery
          Icon(FontAwesomeIcons.dollarSign, size: iconSize, color: iconColor),
          const SizedBox(width: 6), // small consistent spacing
          Text(
            isDelivered
                ? "Delivery: ${priceDelivery.withComma} "
                : "Free Delivery",
            style: textStyle,
          ),

          const Spacer(), // pushes next section to center/right
          // Delivery Time
          Icon(FontAwesomeIcons.solidClock, size: iconSize, color: iconColor),
          const SizedBox(width: 6),
          Text("${avgCookingTime.join("-")} min", style: textStyle),

          const Spacer(), // pushes rating to the end
          // Rating
          Icon(FontAwesomeIcons.solidStar, size: iconSize, color: iconColor),
          const SizedBox(width: 6),
          Text(rating.toString(), style: textStyle),
        ],
      ),
    );
  }

  Widget _description({required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

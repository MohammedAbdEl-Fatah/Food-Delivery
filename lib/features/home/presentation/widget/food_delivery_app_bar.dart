import 'package:flutter/widgets.dart';
import 'package:food_delivery/features/home/presentation/widget/custom_app_bar.dart';
import '../../../../core/Colors/color_manager.dart';
import '../../../../core/contents/images.dart';
import '../../../../core/style/app_text_style.dart';

class FoodDeliveryAppBar extends StatelessWidget {
  const FoodDeliveryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageResources.appBar),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.only(top: 62.0),
          child: Column(
            spacing: 8,
            children: [
              const CustomAppBar(),

              //header
              Align(
                heightFactor: 1.2,
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Provide the best \nfood for you',
                  style: AppTextStyle.header3.copyWith(
                    color: ColorManager.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

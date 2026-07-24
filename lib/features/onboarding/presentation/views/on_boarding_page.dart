import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/features/onboarding/domain/entities_model.dart';
import 'package:food_delivery/features/onboarding/domain/repositories/on_boarding_mock_data.dart';
import 'package:food_delivery/features/onboarding/presentation/widget/custom_header.dart';
import 'package:food_delivery/features/onboarding/presentation/widget/custom_navigator_on_boarding.dart';
import '../cubit/on_boarding_cubit.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController; //controller in page view
  final List<OnBoardingEntity> onboardingData =
      EntitiesData.onboardingData; //from domain local

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {
          if (state is OnBoardingStep) {
            _pageController.animateToPage(
              state.step,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInCubic,
            );
          } else if (state is OnBoardingFinished) {
            // Navigate to the main app screen
            Navigator.pushReplacementNamed(
              context,
              ContentsRouter.login,
            ); //todo token when sign in go home
          }
        },
        builder: (context, state) {
          final cubit = context.read<OnBoardingCubit>(); //give data

          int currentStep =
              state is OnBoardingStep
                  ? state.step
                  : 0; //why not value but using state -> value is private or encryption

          return PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length, //3
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(data.image),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.6,
                    bottom: 50,
                    left: 40,
                    right: 40,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(5, 5),
                        blurRadius: 200,
                        blurStyle: BlurStyle.inner,
                      ),
                    ],
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title and Subtitle
                      CustomHeader(data: data),
                      CustomNavigatorOnBoarding(
                        cubit: cubit,
                        onboardingData: onboardingData,
                        currentStep: currentStep,
                        index: index,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

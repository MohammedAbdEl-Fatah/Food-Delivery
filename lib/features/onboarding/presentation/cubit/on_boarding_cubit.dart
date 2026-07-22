import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/contents/enum.dart' show SharedPreferenceKey;
import 'package:food_delivery/core/router/contents_router.dart';

import '../../../../core/storage/shared_preference.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  int _currentStep = 0;
  void next({required int index}) {
    _currentStep = index;
    emit(OnBoardingStep(_currentStep));
  }

  Future<void> skip(BuildContext context) async {
    //route

    await AppPreferences.instance.setBool(
      key: SharedPreferenceKey.seenOnBoarding,
      value: true,
    );
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, ContentsRouter.login);
    }
  }
}

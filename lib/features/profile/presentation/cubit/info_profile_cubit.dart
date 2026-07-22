import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery/core/storage/shared_preference.dart';
import 'package:food_delivery/features/profile/domain/use_case/get_profile_info.dart';

import '../../../../core/contents/enum.dart';
import '../../../../core/model/user_model.dart';

part 'info_profile_state.dart';

class InfoProfileCubit extends Cubit<InfoProfileState> {
  final GetProfileInfo getProfileInfo;
  InfoProfileCubit(this.getProfileInfo) : super(InfoProfileInitial());
  UserModel? userModel;

  Future<void> getProfile() async {
    if (userModel != null) {
      emit(InfoProfileSuccess(userModel!));
      return;
    }
    //emit loading
    emit(InfoProfileLoading());
    try {
      final userID = AppPreferences.instance.getString(
        key: SharedPreferenceKey.userId,
      );

      if (userID.isEmpty) {
        emit(InfoProfileFialure("User not Logged in "));
        return;
      }
      final user = await getProfileInfo(userID);

      userModel = user;
      emit(InfoProfileSuccess(userModel!));
    } catch (e) {
      emit(InfoProfileFialure(e.toString()));
    }
  }

  void clearCache() {
    userModel = null;
  }
}

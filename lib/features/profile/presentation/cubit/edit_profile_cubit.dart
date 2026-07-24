import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery/core/model/user_model.dart';
import 'package:food_delivery/features/profile/domain/use_case/update_profile.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateProfile _updateProfile;

  EditProfileCubit(this._updateProfile) : super(EditProfileInitial());

  Future<void> updateProfile(UserModel userModel) async {
    emit(EditProfileLoading());

    final result = await _updateProfile(userModel);

    result.fold(
      (error) {
        emit(EditProfileError(message: error));
      },
      (_) {
        emit(const EditProfileSuccess(message: 'Profile updated successfully'));
        
      },
    );
  }
}

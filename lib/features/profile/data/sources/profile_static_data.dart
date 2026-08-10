import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/features/profile/domain/entities/profile_item_entity.dart';

class ProfileStaticData {
  static const List<ProfileItemEntity> listProfile = [
    ProfileItemEntity(title: "Personal Date", icon: FontAwesomeIcons.person),
    ProfileItemEntity(title: "Extra Card", icon: FontAwesomeIcons.creditCard),
  ];
  static const List<ProfileItemEntity> listSupport = [
    ProfileItemEntity(title: "Setting", icon: FontAwesomeIcons.gear),
    ProfileItemEntity(title: "Terms of Service", icon: FontAwesomeIcons.fileLines),
    ProfileItemEntity(title: "Help & Support", icon: FontAwesomeIcons.circleInfo),
  ];
}

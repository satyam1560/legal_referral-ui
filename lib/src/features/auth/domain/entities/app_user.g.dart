// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  email: json['email'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  about: json['about'] as String?,
  signupMethod: (json['signup_method'] as num?)?.toInt() ?? 0,
  emailVerified: json['email_verified'] as bool? ?? false,
  mobileVerified: json['mobile_verified'] as bool? ?? false,
  wizardStep: (json['wizard_step'] as num?)?.toInt() ?? 0,
  wizardCompleted: json['wizard_completed'] as bool? ?? false,
  joinDate: _$JsonConverterFromJson<String, DateTime?>(
    json['join_date'],
    const DateTimeConverter().fromJson,
  ),
  mobile: json['mobile'] as String?,
  address: json['address'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  bannerUrl: json['banner_url'] as String?,
  userId: json['user_id'] as String?,
  practiceArea: json['practice_area'] as String?,
  practiceLocation: json['practice_location'] as String?,
  caseResolutionRate: (json['case_resolution_rate'] as num?)?.toInt(),
  averageBillingPerClient: (json['average_billing_per_client'] as num?)
      ?.toInt(),
  experience: json['experience'] as String?,
  openToReferral: json['open_to_referral'] as bool? ?? false,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'email': instance.email,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'about': ?instance.about,
  'signup_method': ?instance.signupMethod,
  'email_verified': ?instance.emailVerified,
  'mobile_verified': ?instance.mobileVerified,
  'wizard_step': ?instance.wizardStep,
  'wizard_completed': ?instance.wizardCompleted,
  'mobile': instance.mobile,
  'address': instance.address,
  'avatar_url': ?instance.avatarUrl,
  'banner_url': ?instance.bannerUrl,
  'user_id': ?instance.userId,
  'practice_area': ?instance.practiceArea,
  'practice_location': ?instance.practiceLocation,
  'case_resolution_rate': ?instance.caseResolutionRate,
  'average_billing_per_client': ?instance.averageBillingPerClient,
  'experience': ?instance.experience,
  'open_to_referral': ?instance.openToReferral,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

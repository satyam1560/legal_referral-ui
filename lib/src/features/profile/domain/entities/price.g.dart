// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Price _$PriceFromJson(Map<String, dynamic> json) => _Price(
  serviceType: $enumDecodeNullable(
    _$PriceServiceTypeEnumMap,
    json['service_type'],
  ),
  perHourPrice: (json['per_hour_price'] as num?)?.toDouble(),
  perHearingPrice: (json['per_hearing_price'] as num?)?.toDouble(),
  contingencyPrice: json['contingency_price'] as String?,
  hybridPrice: json['hybrid_price'] as String?,
  priceId: (json['price_id'] as num?)?.toInt(),
  userId: json['user_id'] as String?,
);

Map<String, dynamic> _$PriceToJson(_Price instance) => <String, dynamic>{
  'service_type': _$PriceServiceTypeEnumMap[instance.serviceType],
  'per_hour_price': ?instance.perHourPrice,
  'per_hearing_price': ?instance.perHearingPrice,
  'contingency_price': ?instance.contingencyPrice,
  'hybrid_price': ?instance.hybridPrice,
};

const _$PriceServiceTypeEnumMap = {
  PriceServiceType.perHour: 'per_hour',
  PriceServiceType.perHearing: 'per_hearing',
  PriceServiceType.contingency: 'contingency',
  PriceServiceType.hybrid: 'hybrid',
};

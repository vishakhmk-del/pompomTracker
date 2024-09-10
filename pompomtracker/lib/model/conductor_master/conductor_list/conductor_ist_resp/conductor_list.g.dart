// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorList _$ConductorListFromJson(Map<String, dynamic> json) =>
    ConductorList(
      conductorId: json['conductor_id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      accountNo: json['account_no'] as String?,
      mobileNo: json['mobile_no'] as String?,
      status: json['status'] as String?,
      registrationNo: json['registration_no'] as String?,
    );

Map<String, dynamic> _$ConductorListToJson(ConductorList instance) =>
    <String, dynamic>{
      'conductor_id': instance.conductorId,
      'name': instance.name,
      'address': instance.address,
      'account_no': instance.accountNo,
      'mobile_no': instance.mobileNo,
      'status': instance.status,
      'registration_no': instance.registrationNo,
    };

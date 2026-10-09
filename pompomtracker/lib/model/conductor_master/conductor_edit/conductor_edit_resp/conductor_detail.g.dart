// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConductorDetail _$ConductorDetailFromJson(Map<String, dynamic> json) =>
    ConductorDetail(
      empId: json['emp_id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      accountNo: json['account_no'] as String?,
      mobileNo: json['mobile_no'] as String?,
      status: json['status'],
      busName: json['bus_name'] as String?,
      registrationNo: json['registration_no'] as String?,
      emailId: json['email_id'] as String?,
      lisenceNo: json['lisence_no'] as String?,
    );

Map<String, dynamic> _$ConductorDetailToJson(ConductorDetail instance) =>
    <String, dynamic>{
      'emp_id': instance.empId,
      'name': instance.name,
      'address': instance.address,
      'account_no': instance.accountNo,
      'mobile_no': instance.mobileNo,
      'status': instance.status,
      'bus_name': instance.busName,
      'registration_no': instance.registrationNo,
      'email_id': instance.emailId,
      'lisence_no': instance.lisenceNo,
    };

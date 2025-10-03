// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterListReq _$MasterListReqFromJson(Map<String, dynamic> json) =>
    MasterListReq(
      empId: json['emp_id'] as String?,
      cname: json['cname'] as String?,
      caddress: json['caddress'] as String?,
      mobNo: json['mob_no'] as String?,
      busRegNo: json['bus_reg_no'] as String?,
      emailId: json['email_id'] as String?,
      status: json['status'] as String?,
      accNo: json['acc_no'] as String?,
      userId: json['user_id'] as String?,
      ownerId: json['owner_id'] as String?,
      usertype: json['user_type'] as String?,
      tripId: json['trip_id'] as String?,
      licenceNo: json['lisence_no'] as String?,
      arrivingTime: json['arriving_time'] as String?,
      departureTime: json['departure_time'] as String?,
      stopName: json['stop_name'] as String?,
      stopNameOld: json['stop_name_old'] as String?,
      stopId: json['stop_id'] as String?,
      km: json['km'] as String?,
      after: (json['after'] as num?)?.toInt(),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      isStage: json['is_stage'] as dynamic,
      stageId: json['stage_id'] as String?,
      regNo: json['reg_no'] as String?,
      routeId: (json['route_id'] as num?)?.toInt(),
      busId: json['bus_id'] as String?,

      flag: json['flag'] as String?,
      role: (json['role'] as num?)?.toInt(),
      emptype: (json['emp_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MasterListReqToJson(MasterListReq instance) =>
    <String, dynamic>{
      'emp_id': instance.empId,
      'cname': instance.cname,
      'caddress': instance.caddress,
      'mob_no': instance.mobNo,
      'bus_reg_no': instance.busRegNo,
      'email_id': instance.emailId,
      'status': instance.status,
      'acc_no': instance.accNo,
      'user_id': instance.userId,
      'owner_id': instance.ownerId,
      'user_type': instance.usertype,
      'trip_id': instance.tripId,
      'lisence_no': instance.licenceNo,
      'arriving_time': instance.arrivingTime,
      'departure_time':instance.departureTime,
      'stop_name': instance.stopName,
      'stop_name_old': instance.stopNameOld,
      'stop_id': instance.stopId,
      'km': instance.km,
      'after': instance.after,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_stage': instance.isStage,
      'stage_id': instance.stageId,
      'reg_no': instance.regNo,
      'route_id': instance.routeId,
      'bus_id':instance.busId,
      'flag': instance.flag,
      'role': instance.role,
      'emp_type': instance.emptype,
    };

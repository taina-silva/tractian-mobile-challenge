import 'package:equatable/equatable.dart';

class CompanyAssetModel extends Equatable {
  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final String? gatewayId;
  final String? sensorId;
  final String? sensorType;
  final String? status;

  const CompanyAssetModel({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.gatewayId,
    this.sensorId,
    this.sensorType,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        locationId,
        parentId,
        gatewayId,
        sensorId,
        sensorType,
        status,
      ];

  factory CompanyAssetModel.fromMap(Map<String, dynamic> map) {
    return CompanyAssetModel(
      id: map['id'],
      name: map['name'],
      locationId: map['locationId'],
      parentId: map['parentId'],
      gatewayId: map['gatewayId'],
      sensorId: map['sensorId'],
      sensorType: map['sensorType'],
      status: map['status'],
    );
  }
}

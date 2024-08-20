import 'package:equatable/equatable.dart';

class CompanyLocationModel extends Equatable {
  final String id;
  final String name;
  final String? parentId;

  const CompanyLocationModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  @override
  List<Object?> get props => [id, name, parentId];

  factory CompanyLocationModel.fromMap(Map<String, dynamic> map) {
    return CompanyLocationModel(
      id: map['id'],
      name: map['name'],
      parentId: map['parentId'],
    );
  }
}

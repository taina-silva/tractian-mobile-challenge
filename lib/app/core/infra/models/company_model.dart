import 'package:equatable/equatable.dart';

class CompanyModel extends Equatable {
  final String id;
  final String name;

  const CompanyModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'],
      name: map['name'],
    );
  }
}

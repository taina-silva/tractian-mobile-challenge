import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';

class CompanyModel {
  String id;
  String name;
  List<CompanyLocationModel> locations;
  List<CompanyAssetModel> assets;

  CompanyModel({
    required this.id,
    required this.name,
    this.locations = const [],
    this.assets = const [],
  });

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'],
      name: map['name'],
    );
  }
}

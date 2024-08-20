import 'package:mobx/mobx.dart';
import 'package:tractian_mobile_challenge/app/core/infra/repositories/companies_repository.dart';
import 'package:tractian_mobile_challenge/app/features/home/presentation/stores/states/home_states.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ICompaniesRepository _repository;

  HomeStoreBase(this._repository);

  @readonly
  GetCompaniesState _state = GetCompaniesInitialState();

  @action
  Future<void> getCompanies() async {
    _state = GetCompaniesLoadingState();

    final r = await _repository.getCompanies();

    r.fold(
      (l) => _state = GetCompaniesErrorState(l.message),
      (r) => _state = GetCompaniesSuccessState(r),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:tractian_mobile_challenge/app/core/components/buttons/custom_button.dart';
import 'package:tractian_mobile_challenge/app/core/components/structure/custom_app_bar.dart';
import 'package:tractian_mobile_challenge/app/core/components/structure/custom_scaffold.dart';
import 'package:tractian_mobile_challenge/app/core/services/app_providers.dart';
import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/pages/assets_page.dart';
import 'package:tractian_mobile_challenge/app/features/home/presentation/stores/home_store.dart';
import 'package:tractian_mobile_challenge/app/features/home/presentation/stores/states/home_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppProviders providers = AppProviders();
  late final HomeStore store;

  @override
  void initState() {
    super.initState();

    store = providers.getIt<HomeStore>();
    store.getCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: Right(Padding(
          padding: const EdgeInsets.symmetric(vertical: DefaultSpace.nano),
          child: Image.asset(Assets.logo),
        )),
        backgroundColor: CColors.primaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(horizontal: DefaultSpace.large),
        child: Observer(builder: (context) {
          if (store.state is GetCompaniesLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: CColors.primaryColor,
            ));
          }

          if (store.state is GetCompaniesErrorState) {
            return Center(
              child: Text((store.state as GetCompaniesErrorState).message),
            );
          }

          if (store.state is GetCompaniesSuccessState) {
            final companies = (store.state as GetCompaniesSuccessState).companies;

            if (companies.isEmpty) {
              return const Center(child: Text('Nenhuma empresa encontrada.'));
            }

            return ListView.separated(
              shrinkWrap: true,
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];

                return CustomButton.primaryRegular(
                  ButtonParameters(
                    width: double.infinity,
                    height: 76,
                    text: Left('${company.name} Unit'),
                    prefixIcon: Right(Image.asset('${Assets.icons}/icon.png')),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssetsPage(companyId: company.id)));
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: DefaultSpace.normal),
            );
          }

          return const SizedBox();
        }),
      ),
    );
  }
}

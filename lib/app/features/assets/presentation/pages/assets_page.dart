import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:tractian_mobile_challenge/app/core/components/fields/common_field.dart';
import 'package:tractian_mobile_challenge/app/core/components/structure/custom_app_bar.dart';
import 'package:tractian_mobile_challenge/app/core/components/structure/custom_scaffold.dart';
import 'package:tractian_mobile_challenge/app/core/services/app_providers.dart';
import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/components/sensor_type_filter.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/components/tree_item_component.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/stores/assets_store.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/stores/states/assets_states.dart';

class AssetsPage extends StatefulWidget {
  final String companyId;

  const AssetsPage({super.key, required this.companyId});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final AppProviders providers = AppProviders();
  late final AssetsStore store;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    store = providers.getIt<AssetsStore>();
    store.getCompanyAssets(widget.companyId);

    _textController.addListener(() {
      store.setTextFilter(_textController.text);
    });
  }

  @override
  void dispose() {
    store.setSensorTypeFilter(null);
    store.setTextFilter(null);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: Right(Padding(
          padding: EdgeInsets.symmetric(vertical: DefaultSpace.nano),
          child: Text('Assets', style: TextStyle(fontSize: FSize.big, color: CColors.neutral0)),
        )),
        backgroundColor: CColors.primaryColor,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(
          vertical: DefaultSpace.large,
          horizontal: DefaultSpace.normal,
        ),
        child: Observer(builder: (context) {
          if (store.state is GetCompanyAssetsLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: CColors.primaryColor,
            ));
          }

          if (store.state is GetCompanyAssetsErrorState) {
            return Center(
              child: Text((store.state as GetCompanyAssetsErrorState).message),
            );
          }

          if (store.state is GetCompanyAssetsSuccessState) {
            return Column(
              children: [
                CommonField(
                  placeholder: 'Buscar Ativo ou Local',
                  controller: _textController,
                  prefixIcon: const Icon(Icons.search, color: CColors.primaryColor),
                  suffixIcon: GestureDetector(
                    onTap: () => _textController.clear(),
                    child: const Icon(Icons.close, color: CColors.primaryColor),
                  ),
                ),
                const SizedBox(height: DefaultSpace.normal),
                const SensorTypeFilter(),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: DefaultSpace.normal),
                    shrinkWrap: true,
                    itemCount: store.currentTreeRootItems.length,
                    itemBuilder: (context, index) =>
                        TreeItemComponent(item: store.currentTreeRootItems[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: DefaultSpace.normal),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        }),
      ),
    );
  }
}

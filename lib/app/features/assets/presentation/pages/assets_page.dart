import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:tractian_mobile_challenge/app/core/components/buttons/custom_button.dart';
import 'package:tractian_mobile_challenge/app/core/components/fields/common_field.dart';
import 'package:tractian_mobile_challenge/app/core/components/structure/custom_app_bar.dart';
import 'package:tractian_mobile_challenge/app/core/components/structure/custom_scaffold.dart';
import 'package:tractian_mobile_challenge/app/core/services/app_providers.dart';
import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/components/sensor_type_filter_component.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/components/tree_item_component.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/stores/assets_store.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/utils/compute-tree/compute_filtered_tree.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/utils/compute-tree/compute_original_tree.dart';
import 'package:tractian_mobile_challenge/app/features/home/presentation/stores/home_store.dart';
import 'package:tractian_mobile_challenge/app/features/home/presentation/stores/states/home_states.dart';

class AssetsPage extends StatefulWidget {
  final String companyId;

  const AssetsPage({super.key, required this.companyId});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final AppProviders providers = AppProviders();
  late final HomeStore homeStore;
  late final AssetsStore assetsStore;

  final TextEditingController _textController = TextEditingController();
  List<ReactionDisposer> reactions = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    homeStore = providers.getIt<HomeStore>();
    assetsStore = providers.getIt<AssetsStore>();

    homeStore.fetchCompanyProperties(widget.companyId);
    if (assetsStore.setCompanyId(widget.companyId)) composeOriginalTree();

    reactions = [
      reaction((_) => homeStore.fetchCompanyPropertiesState, (_) {
        if (homeStore.fetchCompanyPropertiesState is FetchCompanyPropertiesSuccessState) {
          composeOriginalTree();
        }
      }),
    ];
  }

  Future<void> composeOriginalTree() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    final result = await buildOriginalTree(ComputeOriginalTreeRequest(
        homeStore.companyLocations(widget.companyId), homeStore.companyAssets(widget.companyId)));

    assetsStore.treeRootItems = result.treeRootItems;
    assetsStore.originalTreeRootItems = result.treeRootItems;

    setState(() => isLoading = false);
  }

  Future<void> composeFilteredTree() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    final hasTextFilter = assetsStore.textFilter != null && assetsStore.textFilter!.isNotEmpty;
    final hasSensorTypeFilter = assetsStore.sensorFilter != null;

    if (hasTextFilter || hasSensorTypeFilter) {
      final result = await buildFilteredTree(ComputeFilteredTreeRequest(
        Filter(sensorFilter: assetsStore.sensorFilter, textFilter: assetsStore.textFilter),
        assetsStore.originalTreeRootItems,
      ));
      assetsStore.treeRootItems = result.treeRootItems;
    } else {
      assetsStore.treeRootItems = assetsStore.originalTreeRootItems;
    }

    setState(() => isLoading = false);
  }

  void updateTextFilter(String? text) {
    if (text == null) _textController.clear();
    assetsStore.setTextFilter(text);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    composeFilteredTree();
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
        child: Column(
          children: [
            Observer(builder: (context) {
              final fetchState = homeStore.fetchCompanyPropertiesState;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 2 * DefaultSpace.normal) * 0.79,
                    height: 48,
                    child: CommonField(
                      placeholder: 'Buscar Ativo ou Local',
                      controller: _textController,
                      suffixIcon: GestureDetector(
                        onTap: fetchState is FetchCompanyPropertiesLoadingState || isLoading
                            ? null
                            : () => updateTextFilter(null),
                        child: const Icon(Icons.close, color: CColors.primaryColor),
                      ),
                    ),
                  ),
                  CustomButton.primarySmall(
                    ButtonParameters(
                        text: const Right(Icon(Icons.search, color: CColors.neutral0)),
                        width: (MediaQuery.of(context).size.width - 2 * DefaultSpace.normal) * 0.2,
                        height: 48,
                        onTap: () => updateTextFilter(_textController.text),
                        isDisabled: fetchState is FetchCompanyPropertiesLoadingState || isLoading),
                  ),
                ],
              );
            }),
            const SizedBox(height: DefaultSpace.normal),
            SensorTypeFilterComponent(
              currentSensorFilter: assetsStore.sensorFilter,
              onTap: (sensorType) {
                assetsStore.setSensorTypeFilter(sensorType);
                composeFilteredTree();
              },
              onTapIsDisabled:
                  homeStore.fetchCompanyPropertiesState is FetchCompanyPropertiesLoadingState ||
                      isLoading,
            ),
            Observer(builder: (context) {
              final fetchState = homeStore.fetchCompanyPropertiesState;

              if (fetchState is FetchCompanyPropertiesLoadingState || isLoading) {
                return const Padding(
                    padding: EdgeInsets.only(top: 2 * DefaultSpace.extraLarge),
                    child: Center(child: CircularProgressIndicator(color: CColors.primaryColor)));
              }

              if (fetchState is FetchCompanyPropertiesErrorState) {
                return Center(child: Text(fetchState.message));
              }

              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: DefaultSpace.normal),
                  itemCount: assetsStore.treeRootItems.length,
                  itemBuilder: (context, index) => assetsStore.treeRootItems[index].isShown
                      ? TreeItemComponent(item: assetsStore.treeRootItems[index])
                      : const SizedBox(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    assetsStore.treeRootItems = assetsStore.originalTreeRootItems;
    assetsStore.setSensorTypeFilter(null);
    assetsStore.setTextFilter(null);

    super.dispose();
  }
}

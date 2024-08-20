import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:tractian_mobile_challenge/app/core/components/buttons/custom_button.dart';
import 'package:tractian_mobile_challenge/app/core/services/app_providers.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/stores/assets_store.dart';

class SensorTypeFilter extends StatefulWidget {
  const SensorTypeFilter({super.key});

  @override
  State<SensorTypeFilter> createState() => _SensorTypeFilterState();
}

class _SensorTypeFilterState extends State<SensorTypeFilter> {
  final AppProviders providers = AppProviders();
  late final AssetsStore store;

  @override
  void initState() {
    super.initState();

    store = providers.getIt<AssetsStore>();
  }

  @override
  Widget build(BuildContext context) {
    ButtonParameters energyButtonParameters = ButtonParameters(
      text: 'Sensor de Energia',
      prefixIcon: Right(Image.asset(SensorType.energy.icon)),
      onTap: () => store.setSensorTypeFilter(SensorType.energy),
    );

    ButtonParameters vibrationButtonParameters = ButtonParameters(
      text: 'Crítico',
      prefixIcon: Right(Image.asset(SensorType.vibration.icon)),
      onTap: () => store.setSensorTypeFilter(SensorType.vibration),
    );

    return Observer(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: store.sensorTypeFilter == SensorType.energy
                ? CustomButton.primarySmall(energyButtonParameters)
                : CustomButton.secondarySmall(energyButtonParameters),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: store.sensorTypeFilter == SensorType.vibration
                ? CustomButton.primarySmall(vibrationButtonParameters)
                : CustomButton.secondarySmall(vibrationButtonParameters),
          ),
        ],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:tractian_mobile_challenge/app/core/components/buttons/custom_button.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';

class SensorTypeFilterComponent extends StatefulWidget {
  final SensorType? currentSensorFilter;
  final void Function(SensorType) onTap;
  final bool onTapIsDisabled;

  const SensorTypeFilterComponent({
    super.key,
    required this.currentSensorFilter,
    required this.onTapIsDisabled,
    required this.onTap,
  });

  @override
  State<SensorTypeFilterComponent> createState() => _SensorTypeFilterComponentState();
}

class _SensorTypeFilterComponentState extends State<SensorTypeFilterComponent> {
  @override
  Widget build(BuildContext context) {
    ButtonParameters energyButtonParameters = ButtonParameters(
      text: const Left('Sensor de Energia'),
      prefixIcon: Right(Image.asset(SensorType.energy.icon)),
      onTap: () => widget.onTap(SensorType.energy),
      isDisabled: widget.onTapIsDisabled,
    );

    ButtonParameters vibrationButtonParameters = ButtonParameters(
      text: const Left('Crítico'),
      prefixIcon: Right(Image.asset(SensorType.vibration.icon)),
      onTap: () => widget.onTap(SensorType.vibration),
      isDisabled: widget.onTapIsDisabled,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: widget.currentSensorFilter == SensorType.energy
              ? CustomButton.primarySmall(energyButtonParameters)
              : CustomButton.secondarySmall(energyButtonParameters),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: widget.currentSensorFilter == SensorType.vibration
              ? CustomButton.primarySmall(vibrationButtonParameters)
              : CustomButton.secondarySmall(vibrationButtonParameters),
        ),
      ],
    );
  }
}

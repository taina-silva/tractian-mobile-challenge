import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tractian_mobile_challenge/app/core/components/structure/custom_scaffold.dart';
import 'package:tractian_mobile_challenge/app/core/services/app_providers.dart';
import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';
import 'package:tractian_mobile_challenge/app/features/splash/presentation/stores/splash_store.dart';
import 'package:tractian_mobile_challenge/app/features/splash/presentation/stores/states/splash_states.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AppProviders providers = AppProviders();
  late final SplashStore store;
  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    store = providers.getIt<SplashStore>();
    store.manageSplash();

    reactions = [
      reaction((_) => store.state, (SplashState state) async {
        if (state is ToEntryState) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: CColors.primaryColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.logo),
          ],
        ),
      ),
    );
  }
}

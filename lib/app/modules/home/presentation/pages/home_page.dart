import 'package:flutter/material.dart';
import 'package:tractian_mobile_challenge/app/core/components/structure/custom_scaffold.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

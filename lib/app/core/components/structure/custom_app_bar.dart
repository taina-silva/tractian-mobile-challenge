import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';

class CustomAppBar extends StatefulWidget {
  final Either<String, Widget> title;
  final List<Widget>? trailing;
  final Widget? leading;
  final Color? backgroundColor;
  final MainAxisAlignment mainAxisAlignment;

  const CustomAppBar({
    super.key,
    required this.title,
    this.trailing,
    this.leading,
    this.backgroundColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? CColors.primaryBackground,
        boxShadow: [Layout.boxShadow],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: DefaultSpace.normal),
            child: Column(
              children: [
                SizedBox(
                  height: Layout.appBarSize,
                  child: Row(
                    mainAxisAlignment: widget.mainAxisAlignment,
                    children: [
                      _renderAppBarLeading(context),
                      GestureDetector(
                        onTap: canPop() ? () => Navigator.of(context).pop() : null,
                        child: widget.title.fold(
                          (title) => Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FWeight.bold,
                              color: CColors.neutral900,
                            ),
                          ),
                          (widget) => Container(
                            alignment: Alignment.center,
                            child: widget,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool canPop() => Navigator.of(context).canPop();

  Widget _renderAppBarLeading(BuildContext context) {
    if (widget.leading != null) {
      return Container(
        margin: const EdgeInsets.only(right: Layout.appBarLeadingAndTrailingWidth / 4),
        child: widget.leading!,
      );
    }

    if (canPop()) {
      return Container(
        margin: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: CColors.neutral0,
            size: Layout.appBarLeadingAndTrailingWidth,
          ),
        ),
      );
    }

    return const SizedBox();
  }
}

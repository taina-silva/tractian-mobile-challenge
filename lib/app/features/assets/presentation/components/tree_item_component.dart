import 'package:flutter/material.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';

class TreeItemComponent extends StatefulWidget {
  final TreeItem item;

  const TreeItemComponent({super.key, required this.item});

  @override
  State<TreeItemComponent> createState() => _TreeItemComponentState();
}

class _TreeItemComponentState extends State<TreeItemComponent> {
  void closeChildren(TreeItem item) {
    item.isExpanded = false;
    for (var i in item.children) {
      closeChildren(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Image.asset(widget.item.type.icon),
      title: Wrap(
        children: [
          Text(
            widget.item.name,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          if (widget.item.sensorType != null)
            Image.asset(widget.item.sensorType!.icon, width: 24, height: 24),
        ],
      ),
      backgroundColor: CColors.primaryBackground,
      onExpansionChanged: (bool expanding) {
        setState(() {
          widget.item.isExpanded = expanding;
          if (!expanding) closeChildren(widget.item);
        });
      },
      trailing: widget.item.children.isNotEmpty
          ? Icon(
              widget.item.isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
              color: CColors.primaryColor,
            )
          : const SizedBox(),
      tilePadding: const EdgeInsets.all(0),
      children: widget.item.isExpanded
          ? widget.item.children
              .map((child) => child.isShown ? TreeItemComponent(item: child) : const SizedBox())
              .toList()
          : [],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';

class TreeItemComponent extends StatefulWidget {
  final TreeItem item;

  const TreeItemComponent({super.key, required this.item});

  @override
  State<TreeItemComponent> createState() => _TreeItemComponentState();
}

class _TreeItemComponentState extends State<TreeItemComponent> {
  @override
  initState() {
    super.initState();
    widget.item.isExpanded = false;
  }

  void toggleExpansion() {
    final expanding = !widget.item.isExpanded;
    if (widget.item.isExpanded || !expanding) {
      for (var i in widget.item.children) {
        i.isExpanded = false;
      }
    }
    setState(() => widget.item.isExpanded = expanding);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.item.parent == null ? 0 : DefaultSpace.normal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
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
            leading: Image.asset(widget.item.type.icon),
            trailing: widget.item.children.isNotEmpty
                ? Icon(widget.item.isExpanded
                    ? Icons.keyboard_arrow_down_outlined
                    : Icons.keyboard_arrow_right_outlined)
                : null,
            onTap: () => toggleExpansion(),
          ),
          if (widget.item.isExpanded)
            CustomScrollView(
              shrinkWrap: true,
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = widget.item.children[index];
                      if (!item.isShown) return const SizedBox();
                      return TreeItemComponent(item: item);
                    },
                    childCount: widget.item.children.length,
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}

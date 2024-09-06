import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';

class Filter {
  String? textFilter;
  SensorType? sensorFilter;

  Filter({this.textFilter, this.sensorFilter});

  bool get hasTextFilter => textFilter != null && textFilter!.isNotEmpty;

  bool get hasSensorFilter => sensorFilter != null;

  bool matchesTextFilter(String filter) =>
      hasTextFilter && filter.toLowerCase().contains(textFilter!.toLowerCase());

  bool matchesSensorTypeFilter(SensorType filter) => hasSensorFilter && sensorFilter == filter;
}

class ComputeFilteredTreeRequest extends Equatable {
  final Filter filter;
  final List<TreeItem> treeRootItems;

  const ComputeFilteredTreeRequest(this.filter, this.treeRootItems);

  @override
  List<Object?> get props => [filter, treeRootItems];
}

class ComputeFilteredTreeResponse extends Equatable {
  final List<TreeItem> treeRootItems;

  const ComputeFilteredTreeResponse(this.treeRootItems);

  @override
  List<Object?> get props => [treeRootItems];
}

Future<ComputeFilteredTreeResponse> buildFilteredTree(ComputeFilteredTreeRequest request) async {
  try {
    final result = await compute<ComputeFilteredTreeRequest, ComputeFilteredTreeResponse>(
      computeFilteredTree,
      ComputeFilteredTreeRequest(request.filter, request.treeRootItems),
    );
    return result;
  } catch (error) {
    throw Exception(error);
  }
}

ComputeFilteredTreeResponse computeFilteredTree(ComputeFilteredTreeRequest params) {
  Filter filter = params.filter;
  List<TreeItem> treeRootItems = params.treeRootItems;

  for (var node in treeRootItems) {
    if (!filter.hasTextFilter && filter.hasSensorFilter) {
      searchForSensorMatch(node, filter);
    } else if (filter.hasTextFilter && !filter.hasSensorFilter) {
      searchForTextMatch(node, filter);
    } else {
      searchForTextMatch(node, filter);
      searchForSensorMatch(node, filter, searchForTextMatchFirst: true);
    }
  }

  return ComputeFilteredTreeResponse(treeRootItems);
}

bool searchForSensorMatch(TreeItem node, Filter filter, {searchForTextMatchFirst = false}) {
  bool isCurrentNodeShown =
      node.sensorType != null && filter.matchesSensorTypeFilter(node.sensorType!);
  bool hasMatchingChild = false;

  for (TreeItem child in node.children) {
    if (searchForTextMatchFirst && !node.isShown) break;
    bool isChildShown = searchForSensorMatch(child, filter);
    if (isChildShown) hasMatchingChild = true;
  }

  node.isExpanded = false;
  node.isShown = isCurrentNodeShown || hasMatchingChild;
  return node.isShown;
}

bool searchForTextMatch(TreeItem node, Filter filter) {
  node.isShown = filter.matchesTextFilter(node.name);

  if (node.isShown) {
    node.isExpanded = false;
    setIsShownRecursively(node, true);
    return true;
  }

  node.isShown = node.children.any((child) => searchForTextMatch(child, filter));
  if (node.isShown) node.isExpanded = false;

  return node.isShown;
}

void setIsShownRecursively(TreeItem node, bool isShown) {
  node.isShown = isShown;
  node.isExpanded = false;

  for (TreeItem child in node.children) {
    setIsShownRecursively(child, isShown);
  }
}

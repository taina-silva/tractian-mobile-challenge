class ComputeParams<T> {
  final List<dynamic> response;
  final T Function(Map<String, dynamic>) fromMap;

  ComputeParams(this.response, this.fromMap);
}

List<T> parseItemsInBackground<T>(ComputeParams<T> params) {
  return params.response.map((item) => params.fromMap(item)).toList();
}

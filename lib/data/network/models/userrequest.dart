class UserRequest0 {
  int page;
  int count;
  String sortBy;
  String direction;
  String search;
  List<String> columns;

  UserRequest0(
    this.page,
    this.count,
    this.sortBy,
    this.direction,
    this.search,
    this.columns,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['count'] = count;
    if (sortBy.isNotEmpty) data['sortBy'] = sortBy;
    if (direction.isNotEmpty) data['direction'] = direction;
    if (search.isNotEmpty) data['search'] = search;
    if (columns.isNotEmpty) data['columns'] = columns;
    return data;
  }
}

class TodoTableQuery {
  int? limit;
  int? offset;
  String? orderProperty;
  OrderByMethod? orderBy;

  TodoTableQuery({this.offset, this.limit, this.orderProperty, this.orderBy});
}

enum OrderByMethod { desc, ask }

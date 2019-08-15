library sql_meta_data;

class Table {
  final String tableName;
  final  List<String> columns;
  final List<String>  types;
  const Table({this.tableName,this.columns,this.types});
}

class Entity {
  const Entity();

}

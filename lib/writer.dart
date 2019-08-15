import 'table.dart';

class TableWriter {
  List<String> schemas = [];
   addSchema({String tableName,List columns,List types}) {
     List result = [];
     for(int i = 0; i < columns.length; i ++) {
      result.add("${columns[i]} ${types[i]}");
     }
     String sql = "CREATE TABLE $tableName (${result.join(",")});";

     print(sql);

     schemas.add(sql);
  }

  String write() {
     //'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)')
    return  '''
      const table_schemas = [
        ${schemas.map((o) {
          return "\" $o \"";
    }).toList().join(",\n")}
      ];
      ''';

  }
}
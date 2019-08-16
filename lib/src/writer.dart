import '../table.dart';
class TableWriter {
  List<String> tableSchemas = [];
  List<String> indexSchemas = [];

   addSchema({String tableName, List columns ,List indexes = const []}) {
     List tables = [];
     String sql = "CREATE TABLE $tableName (${columns.join(",")});";
     tableSchemas.add(sql);

     if(indexes == null) {
       return;
     }

     for(int i = 0; i < indexes.length;i++) {
        Index index = indexes[i];
        String columns =  index.columns.replaceAll("#", ",");
        String indexSql = "CREATE ${index.unique ? "UNIQUE" : ""} INDEX  ${index.name} ON $tableName ($columns);";
        indexSchemas.add(indexSql);
     }



  }

  String createTable() {
     //'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)')
    return  '''
      const table_schemas = [
        ${tableSchemas.map((o) {
          return "\" $o \"";
    }).toList().join(",\n")}
      ];
      ''';

  }

  String createIndex() {
    return  '''
      const index_schemas = [
        ${indexSchemas.map((o) {
      return "\" $o \"";
    }).toList().join(",\n")}
      ];
      ''';
  }
}
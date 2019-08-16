library sql_meta_data;

//表
class Table {
  final String tableName; //表名
  final String primary; //主键
  final List<Index> indexes;   //索引  ： 联合索引用 "#"分隔
  const Table({this.tableName,this.primary,this.indexes});
}

//列
class Column {
  final String name; //列名 默认为变量名
  final String columnDefinition; //默认为 变量的数据类型
  final bool nullable; //是否可为NULL
  const Column({this.name,this.columnDefinition,this.nullable = true});
}

//主键
class Id {
  const Id();
}

class Index {
  final bool unique; //是否是唯一索引
  final String columns; //索引列，多列用 # 好 分隔； eq: name#user
  final String name; //索引名字  默认为变量名后拼接index
 const Index({this.name,this.columns,this.unique = false});
}


/// 扫描器
/// 扫描Table 注解之后执行
class Scanner {
  const Scanner();
}


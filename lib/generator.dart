import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'table.dart';
import 'package:sql_meta_data/src/writer.dart';
import 'package:source_gen/source_gen.dart';
import 'src/element_resolver.dart';
class TableGenerator extends GeneratorForAnnotation<Table> {

  static  TableWriter writer = TableWriter();
  static  ElementResolver _elementResolver = ElementResolver();

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final String className = element.displayName; //注解所在类的类名
    final String path = buildStep.inputId.path; //注解所在的文件路径
    final String name = annotation.peek("tableName")?.stringValue ?? className; //注解name字段的值
    final List indexes = annotation.peek("indexes")?.listValue; //注解 indexes字段对应的值

    ///获取所有 @Column、@ID 注解所标记的属性，并生成一个列表
    List columns =  _elementResolver.resolveFields((element as ClassElement).fields);

    //获取 索引的值
    List index = indexes?.map((f) {
      String indexColumns = f.getField('columns').toStringValue();  //索引列
      String indexName = f.getField('name').toStringValue() ?? indexColumns.replaceAll("#", "_") + "_index"; //索引名字
      bool isUnique = f.getField('unique').toBoolValue(); //是否是唯一索引
      return Index(name: indexName,columns: indexColumns,unique: isUnique);
    })?.toList();

    //将 建表语句 与 创建索引 语句放进 writer里
    writer.addSchema(tableName: name,indexes:index,columns: columns);

    return null;
  }

}

class ColumnGenerator extends GeneratorForAnnotation<Column> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return null;
  }
}

class IdGenerator extends GeneratorForAnnotation<Id> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return null;
  }
}

class ScannerGenerator extends GeneratorForAnnotation<Scanner> {

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {

   String tables =  TableGenerator.writer.createTable();
   String indexes =  TableGenerator.writer.createIndex();
   return "$tables\n\n$indexes";
  }

}
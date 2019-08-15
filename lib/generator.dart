import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'table.dart';
import 'writer.dart';
import 'package:source_gen/source_gen.dart';

class TableGenerator extends GeneratorForAnnotation<Table> {

  static  TableWriter writer = TableWriter();

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final String className = element.displayName;
    final String path = buildStep.inputId.path;
    final String name = annotation.peek("tableName").stringValue;
    final List columns = annotation.peek("columns").listValue;
    final List types = annotation.peek("types").listValue;

    List c =  columns.map((f){
     return f.toStringValue();
    }).toList();

   List r = types.map((f) {
      return f.toStringValue();
   }).toList();

    writer.addSchema(tableName: name,columns: c,types: r);

    return null;
  }

}

class EntityGenerator extends GeneratorForAnnotation<Entity> {

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    // TODO: implement generateForAnnotatedElement
    return TableGenerator.writer.write();
  }

}
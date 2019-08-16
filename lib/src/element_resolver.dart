import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'dart:core';
import 'package:analyzer/dart/constant/value.dart';



class ElementResolver {

  static const COLUMN = "Column";
  static const ID = "Id";

  void resolveMethods(List<MethodElement> methods) {

  }

  List resolveFields(List<FieldElement> fields) {
    List fieldResult = [];
    for(FieldElement field in fields) {
      //是否主键
      String sqlColumn = "";
      String primaryKey = "";
      for (ElementAnnotation annotation in field.metadata) {
        var result = resolveAnnotation(field, annotation);
          if(result["type"] == COLUMN) {
            sqlColumn = result["data"] ?? "";
          }
          if(result["type"] == ID) {
            primaryKey = result["data"] ?? "";
          }
      }
      fieldResult.add(sqlColumn+primaryKey);
    }
    return fieldResult;
  }

  Map resolveAnnotation(FieldElement field,ElementAnnotation elementAnnotation) {
    final metadata = elementAnnotation.computeConstantValue();

    final typeName = metadata.type.name;

    switch(typeName) {
      case "Column":
        String column = resolveColumn(field,metadata);
        return {"data":column,"type":COLUMN};
      case "Id":
        return  {"data":"PRIMARY KEY","type":ID};
      default:
        return {};
    }

  }

  String resolveColumn(FieldElement fieldElement,DartObject columnObject) {

    String fieldClassName = fieldElement.type.displayName;
    String fieldName = fieldElement.name;

    String name = columnObject.getField("name").toStringValue() ?? fieldName;
    String columnDefinition = columnObject.getField("columnDefinition").toStringValue() ?? _mapToSqliteDataType(fieldClassName);

    bool nullable = columnObject.getField("nullable").toBoolValue();
    return "$name $columnDefinition ${nullable ? "" : "NOT NULL"}";
  }

  String _mapToSqliteDataType(String type) {
    print("数据类型：$type");
    switch (type) {
      case "String":
        return "TEXT";
      case "num":
        return "DOUBLE";
      case "int":
        return "INT";
      case "double":
        return "DOUBLE";
      case "bool":
        return "BOOL";
    }
    return null;
  }

}
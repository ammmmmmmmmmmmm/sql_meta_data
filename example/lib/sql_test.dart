
import 'package:sql_meta_data/sql_meta_data.dart';

@Table(tableName: "user",columns: ["name","age","grade"],types: ["text primary key","int","text"])
class User {
  String name;
  int age;
  String grade;
}


@Table(tableName: "school",columns: ["student","teacher"],types: ["text","text"])
class School {

  String student;
  String teacher;

}

@Entity()
class DB {


}
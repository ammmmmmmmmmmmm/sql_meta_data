
import 'package:sql_meta_data/sql_meta_data.dart';


class User {
  String name;
  int age;
  String grade;
}


@Table(tableName: "school",indexes: [Index(columns: "teacher",name: "teacher_index")])
class School {

  @Id()
  @Column()
  int id;

  @Column(name: "student")
  String student;

  @Column(name: "teacher")
  String teacher;

  @Column(name: "num")
  int num;

  @Column()
  double grads;
}


@Scanner()
class DB {

}
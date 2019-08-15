import 'package:build/build.dart';
import './generator.dart';
import 'package:source_gen/source_gen.dart';

Builder tableBuilder(BuilderOptions options ) => LibraryBuilder(TableGenerator());
Builder entityBuilder(BuilderOptions options) => LibraryBuilder(EntityGenerator(),generatedExtension: '.internal.dart');
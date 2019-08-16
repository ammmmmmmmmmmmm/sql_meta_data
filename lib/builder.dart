import 'package:build/build.dart';
import './generator.dart';
import 'package:source_gen/source_gen.dart';

Builder tableBuilder(BuilderOptions options ) => LibraryBuilder(TableGenerator());
Builder scannerBuilder(BuilderOptions options) => LibraryBuilder(ScannerGenerator(),generatedExtension: '.internal.dart');
Builder columnBuilder(BuilderOptions options) => LibraryBuilder(ColumnGenerator());
Builder IDBuilder(BuilderOptions options) => LibraryBuilder(IdGenerator());
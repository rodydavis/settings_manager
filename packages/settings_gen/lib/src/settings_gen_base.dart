import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:build/build.dart';
import 'package:settings_gen/src/store_class_visitor.dart';
import 'package:settings_gen/src/template/store_file.dart';
import 'package:settings_gen/src/template/store.dart';
import 'package:settings_gen/src/type_names.dart';
import 'package:source_gen/source_gen.dart';

class StoreGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    if (library.allElements.isEmpty) {
      return '';
    }

    final typeSystem = await library.allElements.first.session.typeSystem;
    final file = StoreFileTemplate()
      ..storeSources = _generateCodeForLibrary(library, typeSystem).toSet();
    return file.toString();
  }

  Iterable<String> _generateCodeForLibrary(
    LibraryReader library,
    TypeSystem typeSystem,
  ) sync* {
    for (final classElement in library.classes) {
      if (isMixinStoreClass(classElement)) {
        yield* _generateCodeForMixinStore(library, classElement, typeSystem);
      }
    }
  }

  Iterable<String> _generateCodeForMixinStore(
    LibraryReader library,
    ClassElement baseClass,
    TypeSystem typeSystem,
  ) sync* {
    final typeNameFinder = LibraryScopedNameFinder(library.element);
    final otherClasses = library.classes.where((c) => c != baseClass);
    final mixedClass = otherClasses.firstWhere((c) {
      if (baseClass.typeParameters.length != c.supertype.typeArguments.length) {
        return false;
      }

      return typeSystem.isSubtypeOf(
          c.type, baseClass.type.instantiate(c.supertype.typeArguments));
    }, orElse: () => null);

    if (mixedClass != null) {
      yield _generateCodeFromTemplate(
          mixedClass.name, baseClass, MixinStoreTemplate(), typeNameFinder);
    }
  }

  String _generateCodeFromTemplate(
    String publicTypeName,
    ClassElement userStoreClass,
    StoreTemplate template,
    LibraryScopedNameFinder typeNameFinder,
  ) {
    final visitor = StoreClassVisitor(
        publicTypeName, userStoreClass, template, typeNameFinder);
    userStoreClass
      ..accept(visitor)
      ..visitChildren(visitor);
    return visitor.source;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SplashStore on SplashStoreBase, Store {
  late final _$_stateAtom =
      Atom(name: 'SplashStoreBase._state', context: context);

  SplashState get state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  SplashState get _state => state;

  @override
  set _state(SplashState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$manageSplashAsyncAction =
      AsyncAction('SplashStoreBase.manageSplash', context: context);

  @override
  Future<void> manageSplash() {
    return _$manageSplashAsyncAction.run(() => super.manageSplash());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}

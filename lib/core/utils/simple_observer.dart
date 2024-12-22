import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log("state changed : $change");
  }

  @override
  void onClose(BlocBase bloc) {
    log("close: $bloc");
  }

  @override
  void onCreate(BlocBase bloc) {
    log("create: $bloc");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log("error: $bloc");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    //implement onEvent
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    //implement onTransition
  }
}

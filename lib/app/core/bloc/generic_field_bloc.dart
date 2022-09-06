import 'dart:async';

import 'package:flutter_movies_db/app/core/bloc/validators/validators.dart';

import 'generic.bloc.dart';
import 'models/default_validator_model.dart';

class GenericFieldBloc<T> extends Bloc<T> {
  GenericFieldBloc({
    this.defaultValue,
    this.defaultValidators,
    this.onValidateCustom,
    this.forceValid = false,
  }) : super(validator: null, init: defaultValue) {
    if (defaultValidators != null) {
      verficateDefaultValidators(defaultValidators);
      validator = customStreamTransformer(defaultValidators, type);
      if (forceValid) {
        sink(defaultValue);
      }
    }
  }

  GenericFieldBloc<T> setValidators(DefaultValidators validators,
      {T? defaultValue, Function(EventSink<T?>, T?)? onValidateCustom}) {
    verficateDefaultValidators(validators);
    if (validator == null) {
      defaultValidators = validators;
      validator = customStreamTransformer(validators, type);
      if (forceValid) {
        sink(null);
      }
      if (defaultValue != null) {
        sink(defaultValue);
      }
    }
    return this;
  }

  final T? defaultValue;
  final bool forceValid;

  DefaultValidators? defaultValidators;
  EventSink<T?>? eventSink;
  final Function(EventSink<T?>, T?)? onValidateCustom;

  void clearValidator() {
    if (hasErrorValue) {
      hasErrorSink(false);
      eventSink?.add(value);
      sink(value);
    }
  }

  StreamTransformer<T?, T?> customStreamTransformer(
      DefaultValidators? defaultValidators, Type type) {
    return StreamTransformer<T?, T?>.fromHandlers(
        handleData: (T? value, EventSink<T?> sink) {
      final String? hasErrorMessage =
          Validators.hasErrorDefaultValidators(defaultValidators, value, type);
      if (hasErrorMessage != null) {
        hasErrorSink(true);
        sink.addError(hasErrorMessage);
      } else {
        hasErrorSink(false);
        sink.add(value);
        // Se envia para validaciones customizadas
        if (onValidateCustom != null) {
          onValidateCustom!(sink, value);
        }
        eventSink = sink;
      }
    });
  }

  @override
  String toString() {
    return '$type = $value;';
  }
}

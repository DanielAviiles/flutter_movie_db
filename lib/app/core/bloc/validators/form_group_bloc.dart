import 'dart:async';
import 'dart:developer';
import 'package:flutter_movies_db/app/core/bloc/generic_field_bloc.dart';
import 'package:flutter_movies_db/app/core/utils/extension_utils.dart';
import 'package:rxdart/rxdart.dart';

class FormGroupBloc {
  FormGroupBloc({this.blocs, this.initialVerification = false})
      : assert(blocs != null && blocs.isNotEmpty,
            'The "blocs" property cannot be null or empty') {
    //
    //  Initialization of the internal Stream controller
    //
    _controller = BehaviorSubject<bool>();
    _listenBlocs(blocs);
  }

  GenericFieldBloc<T>? getBloc<T>(String key) {
    try {
      return blocs![key]! as GenericFieldBloc<T>;
    } catch (e) {
      log('key no exist $e');
      return null;
    }
  }

  //
  // Stream which emits the actual validation result, combining
  // all the streams involved in the validation
  //
  final bool initialVerification;
  final Map<String, GenericFieldBloc<dynamic>>? blocs;
  late BehaviorSubject<bool> _controller;

  //
  // Method which initializes the validation
  //
  void _listenBlocs(Map<String, GenericFieldBloc<dynamic>>? blocs) {
    // For each of the streams to be considered, listen
    // to the type of information they are going to emit
    //
    blocs?.forEach((String key, GenericFieldBloc<dynamic> value) {
      blocs[key]!.stream.listen(
        (dynamic data) {
          blocs[key]!.hasErrorSink(false);
          // Data was emitted => this is not an error
          _validate(blocs);
        },
        onError: (dynamic _) {
          // Error was emitted
          blocs[key]!.hasErrorSink(true);
          _validate(blocs);
        },
      );
    });

    blocs?.forEach((String key, GenericFieldBloc<dynamic> value) {
      if (blocs[key]?.validator != null) {
        //has validation
        blocs[key]!.hasErrorSink(true);
      }
      //Initial Validation Fields
      if (initialVerification) {
        if (blocs[key]?.defaultValue == null) {
          blocs[key]!.sink(null);
        }
      }
    });

    _validate(blocs);
  }

  //
  // Routine which simply checks whether there is still at least one
  // stream which does not satisfy the validation
  // Depending on this check, emits a positive or negative validation outcome
  //
  bool _validate(Map<String, GenericFieldBloc<dynamic>>? blocs) {
    final bool hasNoErrors = blocs?.values.firstWhereOrNull(
            (GenericFieldBloc<dynamic> b) => b.hasErrorValue == true) ==
        null;
    sinkValid(hasNoErrors);
    return hasNoErrors;
  }

  //
  // Public outcome of the validation
  //
  Stream<bool> get isValidStream => _controller.stream;
  bool get isValid => _controller.valueOrNull ?? false;
  Function(bool) get sinkValid => _controller.sink.add;

  ///Dispose
  void dispose() {
    blocs?.forEach((String key, GenericFieldBloc<dynamic> value) {
      blocs![key]!.dispose();
    });
    _controller.close();
  }
}

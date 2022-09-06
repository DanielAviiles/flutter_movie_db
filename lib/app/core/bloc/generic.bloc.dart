import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'exception.assert.dart';

class Bloc<T> extends ExceptionAssert<T> implements BlocBase {
  //Constructor
  // ===========================================================================
  Bloc({this.validator, this.init}) {
    if (init != null) {
      sink(init);
    }
  }
  //Properties
  // ===========================================================================
  final BehaviorSubject<bool> hasErrorController = BehaviorSubject<bool>();
  final BehaviorSubject<bool> hideValueController = BehaviorSubject<bool>.seeded(true);

  final BehaviorSubject<T?> controller = BehaviorSubject<T?>();
  StreamTransformer<T?, T?>? validator;
  final T? init;


  // Recuperar los datos del Stream (STREAM)
  Stream<T?> get stream {
    if (validator != null) {
      /* final Stream<T> mapStream = controller.stream.map<T>((T? e) {
        return e!;
      }); */ // mapear stream Stream<T?> a Stream<T>,  mapStream.transform= genera error cuando tranforma con  Stream<T?> se mapea para cambiar a Stream<T> , transform no puede recibir valores null
      return controller.stream.transform(validator!);
    }
    return controller.stream;
  }

  Stream<T> get streamNotNull {
    if (validator != null) {
      final StreamTransformer<T, T> validatorCus = validator!.cast<T, T>();
      final Stream<T> mapStream = controller.stream.map<T>((T? e) {
        assert(e != null, 'Value is null error');
        return e!;
      }); // mapear stream Stream<T?> a Stream<T>,  mapStream.transform= genera error cuando tranforma con  Stream<T?> se mapea para cambiar a Stream<T> , transform no puede recibir valores null
      return mapStream.transform(validatorCus);
    }
    final Stream<T> mapStream = controller.stream.map<T>((T? e) {
      assert(e != null, 'Value is null error');
      return e!;
    }); // mapear stream Stream<T?> a Stream<T>,  mapStream.transform= genera error cuando tranforma con  Stream<T?> se mapea para cambiar a Stream<T> , transform no puede recibir valores null
    return mapStream;
  }

  // Insertar valores al Stream  (SINK)
  Function(T?) get sink => controller.sink.add;
  Function(bool) get hasErrorSink => hasErrorController.sink.add;
  Function(bool) get hideValueSink => hideValueController.sink.add;

  // Obtener el último valor ingresado a los streams (VALUE)
  T? get value => controller.valueOrNull;
  bool get hasErrorValue => hasErrorController.valueOrNull??false;

  //Dispose se ejecute para cerrar suscripciones al controlador
  @override
  void dispose() {
    //sink(null);
    controller.close();
    hasErrorController.close();
    hideValueController.close();
  }
}
abstract class BlocBase {
  void dispose();
}

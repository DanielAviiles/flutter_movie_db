abstract class UseCase<Type, Params> {
  Future<Type?> execute(Params params);
}

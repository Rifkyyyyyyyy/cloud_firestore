abstract class Usecase<Type, Params> {
  Future<Type> call({Params params});
}

abstract class Usecase2<Type, Params> {
  Stream<Type> call({Params params});
}

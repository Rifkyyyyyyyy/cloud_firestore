abstract class DataState<T> {
  final T? value;
  final String? err;

  const DataState({this.value, this.err});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T value) : super(value: value);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String err) : super(err: err);
}

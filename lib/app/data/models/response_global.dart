class ResponseGlobal<T> {
  ResponseGlobal(
      {
      this.isSuccess= false,
      this.message,
      this.data});  
  bool isSuccess;
  String? message;
  T? data;
}
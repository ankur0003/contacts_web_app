class APIManager<T>{
  final bool success;
  final T? data;
  final String? error;
  final int? code;


  APIManager({required this.success, this.data, this.error,this.code});
}
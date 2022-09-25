class APIResponse<T> {
  final T? data;
  final bool error;
  String errormessage;

  APIResponse({
    required this.errormessage,
    this.data,
    this.error = false,
  });
}

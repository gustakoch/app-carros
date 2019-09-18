class ApiResponse<T> {
  bool isOk;
  String message;
  T result;

  ApiResponse.isOk(this.result) {
    isOk = true;
  }

  ApiResponse.error(this.message) {
    isOk = false;
  }
}

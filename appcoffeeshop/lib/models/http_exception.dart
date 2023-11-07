class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  HttpException.firebase(String code)
      : message = _translateFirebaseErrorCode(code);

  static String _translateFirebaseErrorCode(code) {
    switch (code) {
      case 'EMAIL_EXISTS':
        return 'Email này đã tồn tại!';
      case 'INVALID_EMAIL':
        return 'Email này không hợp lệ!';
      case 'WEAK_PASSWORD':
        return 'Mật khẩu yếu!';
      case 'EMAIL_NOT_FOUND':
        return 'Không tìm thấy email này!';
      case 'INVALID_PASSWORD':
        return 'Mật khẩu không hợp lệ';
      default:
        return code;
    }
  }

  @override
  String toString() {
    return message;
  }
}

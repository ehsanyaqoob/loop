class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final int? statusCode;
  final Map<String, dynamic>? errors;
  final String? errorCode;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.statusCode,
    this.errors,
    this.errorCode,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json)? fromJsonT) {
    return ApiResponse<T>(
      success: _parseSuccess(json),
      message: _parseMessage(json),
      data: _parseData(json, fromJsonT),
      statusCode: json['statusCode'] ?? json['code'],
      errors: _parseErrors(json),
      errorCode: json['errorCode'] ?? json['error_type'],
    );
  }

  static bool _parseSuccess(Map<String, dynamic> json) {
    if (json['success'] == true) return true;
    if (json['status'] == 'success') return true;
    if (json['isSuccess'] == true) return true;
    
    final statusCode = json['statusCode'];
    if (statusCode != null && statusCode >= 200 && statusCode < 300) return true;
    
    final message = json['message']?.toString().toLowerCase() ?? '';
    if (message.contains('success')) return true;
    if (message.contains('created')) return true;
    if (message.contains('registered')) return true;
    if (message.contains('verified')) return true;
    if (message.contains('login')) return true;
    
    return false;
  }

  static String _parseMessage(Map<String, dynamic> json) {
    return json['message'] ?? 
           json['msg'] ?? 
           json['error'] ?? 
           json['error_message'] ?? 
           '';
  }

  static T? _parseData<T>(Map<String, dynamic> json, T Function(Object? json)? fromJsonT) {
    final dynamic data = json['data'] ?? json['result'] ?? json['response'] ?? json['body'] ?? json;
    
    if (data == null) return null;
    if (fromJsonT == null) return data as T?;
    
    try {
      return fromJsonT(data);
    } catch (e) {
      return null;
    }
  }

  static Map<String, dynamic>? _parseErrors(Map<String, dynamic> json) {
    final errors = json['errors'] ?? json['error_details'] ?? json['validation_errors'];
    if (errors is Map<String, dynamic>) return errors;
    if (errors is List) return {'general': errors};
    return null;
  }

  Map<String, dynamic> toJson(Object Function(T? value)? toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': toJsonT != null && data != null ? toJsonT(data) : data,
      if (statusCode != null) 'statusCode': statusCode,
      if (errors != null) 'errors': errors,
      if (errorCode != null) 'errorCode': errorCode,
    };
  }

  bool get hasErrors => errors != null && errors!.isNotEmpty;
  bool get isUnauthorized => statusCode == 401;
  bool get isServerError => statusCode != null && statusCode! >= 500;

  @override
  String toString() {
    return 'ApiResponse(success: $success, message: $message, data: $data, statusCode: $statusCode)';
  }
}


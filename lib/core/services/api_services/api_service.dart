import 'package:http/http.dart' as http;

import 'package:loop/core/services/storage-services.dart';
import 'package:loop/export.dart';

class ApiService with ChangeNotifier {
  final String baseUrl = '${Config.pro_base_url}api';
   
  ApiService({required StorageService storageService}); // No storageService dependency

  Future<Map<String, String>> _getHeaders(bool authorization) async {
    final headers = {'Content-Type': 'application/json'};
    if (authorization) {
      // Access via global navigator key or context
      final storageService = Navigate.navigatorKey.currentContext!.read<StorageService>();
      final token = await storageService.getAuthToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }
Future<ApiResponse<T>> _handleRequest<T>({
  required Future<http.Response> request,
  required T Function(dynamic) fromJson,
}) async {
  final response = await request;

  print('Response Status: ${response.statusCode}');
  print('Response Body: ${response.body}');

  final decoded = json.decode(response.body);

  // 🧠 Handle both Map and List responses
  final Map<String, dynamic> data = decoded is Map<String, dynamic>
      ? decoded
      : {'data': decoded}; // Wrap lists inside { data: [...] }

  if (response.statusCode >= 200 && response.statusCode <= 299) {
    final apiResponse = ApiResponse<T>.fromJson(data, fromJson);

    return ApiResponse<T>(
      success: apiResponse.success,
      message: apiResponse.message,
      data: apiResponse.data,
      statusCode: response.statusCode,
      errors: apiResponse.errors,
      errorCode: apiResponse.errorCode,
    );
  } else if (response.statusCode >= 400 && response.statusCode <= 499) {
    final apiResponse = ApiResponse<T>.fromJson(data, fromJson);

    return ApiResponse<T>(
      success: false,
      message: apiResponse.message.isNotEmpty
          ? apiResponse.message
          : _getDefaultErrorMessage(response.statusCode),
      data: apiResponse.data,
      statusCode: response.statusCode,
      errors: apiResponse.errors,
      errorCode: apiResponse.errorCode,
    );
  } else {
    throw NetworkException(
        'Server responded with status: ${response.statusCode}');
  }
}

  String _getDefaultErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 422:
        return 'Validation Error';
      default:
        return 'Request failed with status $statusCode';
    }
  }

  Future<ApiResponse<T>> get<T>(
    String endpoint,
    bool authorization,
    T Function(dynamic) fromJson,
  ) async {
    final headers = await _getHeaders(authorization);
    final String fullUrl = '$baseUrl$endpoint';

    print('GET Request: $fullUrl');
    print('Headers: $headers');

    return _handleRequest<T>(
      request: http.get(Uri.parse(fullUrl), headers: headers),
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint,
    Map<String, dynamic> body,
    bool authorization,
    T Function(dynamic) fromJson,
  ) async {
    final headers = await _getHeaders(authorization);
    final String fullUrl = '$baseUrl$endpoint';

    body['version'] = '3.0.1';

    print('POST Request: $fullUrl');
    print('Headers: $headers');
    print('Request Body: ${json.encode(body)}');

    return _handleRequest<T>(
      request: http.post(
        Uri.parse(fullUrl),
        headers: headers,
        body: json.encode(body),
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> put<T>(
    String endpoint,
    Map<String, dynamic> body,
    bool authorization,
    T Function(dynamic) fromJson,
  ) async {
    final headers = await _getHeaders(authorization);
    final String fullUrl = '$baseUrl$endpoint';

    print('PUT Request: $fullUrl');
    print('Headers: $headers');
    print('Request Body: ${json.encode(body)}');

    return _handleRequest<T>(
      request: http.put(
        Uri.parse(fullUrl),
        headers: headers,
        body: json.encode(body),
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> delete<T>(
    String endpoint,
    bool authorization,
    T Function(dynamic) fromJson,
  ) async {
    final headers = await _getHeaders(authorization);
    final String fullUrl = '$baseUrl$endpoint';

    print('DELETE Request: $fullUrl');
    print('Headers: $headers');

    return _handleRequest<T>(
      request: http.delete(Uri.parse(fullUrl), headers: headers),
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> putMultipart<T>(
    String endpoint,
    Map<String, dynamic> formData,
    bool authorization,
    T Function(dynamic) fromJson,
  ) async {
    final headers = await _getHeaders(authorization);
    headers.remove('Content-Type');

    final String fullUrl = '$baseUrl$endpoint';
    final uri = Uri.parse(fullUrl);

    final request = http.MultipartRequest('PUT', uri)..headers.addAll(headers);

    for (final entry in formData.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is http.MultipartFile) {
        request.files.add(value);
      } else if (value != null) {
        request.fields[key] = value.toString();
      }
    }

    print('PUT Multipart Request: $fullUrl');
    print('Headers: $headers');
    print('Fields: ${request.fields}');
    print('Files: ${request.files.map((f) => f.filename).toList()}');

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = json.decode(response.body);
      return ApiResponse<T>.fromJson(data, fromJson);
    } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      final data = json.decode(response.body);
      final apiResponse = ApiResponse<T>.fromJson(data, fromJson);
      return ApiResponse<T>(
        success: false,
        message: apiResponse.message ?? _getDefaultErrorMessage(response.statusCode),
        data: apiResponse.data,
        statusCode: response.statusCode,
        errors: apiResponse.errors,
        errorCode: apiResponse.errorCode,
      );
    } else {
      throw NetworkException('Upload failed with status: ${response.statusCode}');
    }
  }
}
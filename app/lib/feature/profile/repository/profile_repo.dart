import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// Models
class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final DateTime? createdAt;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      avatar: json['avatar'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

// Result class for better error handling
class Result<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  Result.success(this.data) : error = null, isSuccess = true;

  Result.failure(this.error) : data = null, isSuccess = false;
}

// Repository
class ProfileRepository {
  final String baseUrl;
  final http.Client client;
  String? _authToken;

  ProfileRepository({
    this.baseUrl = 'http://10.0.2.2:8000',
    http.Client? client,
  }) : client = client ?? http.Client();

  // Set authentication token
  void setAuthToken(String token) {
    _authToken = token;
  }

  // Clear authentication token
  void clearAuthToken() {
    _authToken = null;
  }

  // Get headers with auth token
  Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  // Get profile
  Future<Result<ProfileModel>> getProfile() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/profile'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final profile = ProfileModel.fromJson(json['data'] ?? json);
        return Result.success(profile);
      } else if (response.statusCode == 401) {
        return Result.failure('Unauthorized. Please login again.');
      } else {
        final json = jsonDecode(response.body);
        return Result.failure(json['message'] ?? 'Failed to fetch profile');
      }
    } on SocketException {
      return Result.failure('No internet connection');
    } on HttpException {
      return Result.failure('Server error occurred');
    } on FormatException {
      return Result.failure('Invalid response format');
    } catch (e) {
      return Result.failure('An unexpected error occurred: $e');
    }
  }

  // Update profile
  Future<Result<ProfileModel>> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (email != null) body['email'] = email;
      if (phone != null) body['phone'] = phone;

      final response = await client.put(
        Uri.parse('$baseUrl/profile'),
        headers: _getHeaders(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final profile = ProfileModel.fromJson(json['data'] ?? json);
        return Result.success(profile);
      } else if (response.statusCode == 401) {
        return Result.failure('Unauthorized. Please login again.');
      } else {
        final json = jsonDecode(response.body);
        return Result.failure(json['message'] ?? 'Failed to update profile');
      }
    } on SocketException {
      return Result.failure('No internet connection');
    } on HttpException {
      return Result.failure('Server error occurred');
    } on FormatException {
      return Result.failure('Invalid response format');
    } catch (e) {
      return Result.failure('An unexpected error occurred: $e');
    }
  }

  // Upload profile avatar
  Future<Result<String>> uploadAvatar(File imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/profile/avatar'),
      );

      request.headers.addAll(_getHeaders());
      request.files.add(
        await http.MultipartFile.fromPath('avatar', imageFile.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final avatarUrl = json['data']['avatar_url'] ?? json['avatar_url'];
        return Result.success(avatarUrl);
      } else if (response.statusCode == 401) {
        return Result.failure('Unauthorized. Please login again.');
      } else {
        final json = jsonDecode(response.body);
        return Result.failure(json['message'] ?? 'Failed to upload avatar');
      }
    } on SocketException {
      return Result.failure('No internet connection');
    } on HttpException {
      return Result.failure('Server error occurred');
    } catch (e) {
      return Result.failure('An unexpected error occurred: $e');
    }
  }

  // Delete profile
  Future<Result<bool>> deleteProfile() async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/profile'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Result.success(true);
      } else if (response.statusCode == 401) {
        return Result.failure('Unauthorized. Please login again.');
      } else {
        final json = jsonDecode(response.body);
        return Result.failure(json['message'] ?? 'Failed to delete profile');
      }
    } on SocketException {
      return Result.failure('No internet connection');
    } on HttpException {
      return Result.failure('Server error occurred');
    } catch (e) {
      return Result.failure('An unexpected error occurred: $e');
    }
  }

  // Change password
  Future<Result<bool>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/profile/change-password'),
        headers: _getHeaders(),
        body: jsonEncode({
          'current_password': currentPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return Result.success(true);
      } else if (response.statusCode == 401) {
        return Result.failure('Current password is incorrect');
      } else {
        final json = jsonDecode(response.body);
        return Result.failure(json['message'] ?? 'Failed to change password');
      }
    } on SocketException {
      return Result.failure('No internet connection');
    } on HttpException {
      return Result.failure('Server error occurred');
    } catch (e) {
      return Result.failure('An unexpected error occurred: $e');
    }
  }

  // Dispose
  void dispose() {
    client.close();
  }
}

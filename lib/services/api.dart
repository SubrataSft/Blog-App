import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  final String baseUrl = "https://api.zhndev.site/wp-json/blog-app/v1";

  //Login
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {


      return jsonDecode(response.body);
    }
    return null;
  }

  //SignUp
  Future<Map<String, dynamic>?> register(
      String name, String email, String pass, String phone) async {
    final url = Uri.parse("$baseUrl/auth/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": pass,
        "phone": phone,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    return null;
  }

  //Show Profile
  Future<Map<String, dynamic>?> showProfile(String token) async {
    final url = Uri.parse("$baseUrl/user/profile");

    final response =
    await http.get(url, headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  //Update Profile
  Future<Map<String, dynamic>?> updateProfile(
      String token, String name, String email,String phone) async {
    final url = Uri.parse("$baseUrl/user/profile");

    final response = await http.put(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode({"name": name, "email": email,"phone":phone}),
    );

    return jsonDecode(response.body);
  }

  // post
  Future<Map<String, dynamic>?> showPosts() async {
    final url = Uri.parse("$baseUrl/posts");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // comment
  Future<Map<String, dynamic>?> showComments(int postId) async {
    final url = Uri.parse("$baseUrl/comments/post/$postId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  //addComment
  Future<Map<String, dynamic>?> addComment(
      String token, int postId, String content) async {
    final url = Uri.parse("$baseUrl/comments");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "post_id": postId,
        "content": content,
        "parent_id": 0,
      }),
    );

    return jsonDecode(response.body);
  }

  // likes
  Future<Map<String, dynamic>?> fetchLikes(int postId) async {
    final url = Uri.parse("$baseUrl/posts/$postId/like");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // toggle like
  Future<Map<String, dynamic>?> toggleLike(String token, int postId) async {
    final url = Uri.parse("$baseUrl/posts/$postId/like");

    final response = await http.post(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    return jsonDecode(response.body);
  }

  // change password
  Future<Map<String, dynamic>?> changePassword(
      String token, String oldPass, String newPass) async {
    final url = Uri.parse("$baseUrl/user/change-password");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "current_password": oldPass,
        "new_password": newPass,
      }),
    );

    return jsonDecode(response.body);
  }

  // LogOut
  Future<bool> logout(String token) async {
    final url = Uri.parse("$baseUrl/auth/logout");

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Logout Failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Logout API Error: $e");
      return false;
    }
  }
}

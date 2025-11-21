import 'package:flutter/material.dart';
import '../../services/api.dart';
import '../comments_model.dart';
import '../model.dart';


class AuthProvider extends ChangeNotifier {
  final _apiService = AuthApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get data => _userData;


  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  // Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final response = await _apiService.login(email, password);

    _isLoading = false;
    notifyListeners();

    if (response != null) {
      _token = response["token"] ??
          response["data"]?["token"] ??
          response["barer_token"];
      return true;
    }
    return false;
  }

  // SignUp
  Future<bool> signUp(String name, String email, String password, String phone) async {
    _isLoading = true;
    notifyListeners();

    final response = await _apiService.register(name, email, password, phone);

    _isLoading = false;
    notifyListeners();

    if (response != null) {
      _token = response["token"] ?? response["data"]?["token"];
      return true;
    }
    return false;
  }

  //show profile
  Future<void> showProfile() async {
    if (_token == null) return;

    _isLoading = true;
    notifyListeners();

    final response = await _apiService.showProfile(_token!);

    if (response != null) {
      _userData = response["data"];
    }

    _isLoading = false;
    notifyListeners();
  }

  //update profile
  Future<bool> updateProfile(String name, String email,String phone) async {
    if (_token == null) return false;

    final response = await _apiService.updateProfile(_token!, name, email, phone);

    if (response != null && response["success"] == true) {
      await showProfile();
      return true;
    }
    return false;
  }

  // post
  Future<List<Posts>> showPosts() async {
    final response = await _apiService.showPosts();
    if (response != null) {
      PostModel p = PostModel.fromJson(response);
      return p.data!.posts!;
    }
    return [];
  }

  //comments
   Future<List<CommentModel>> showComments(int postId) async {
    final res = await _apiService.showComments(postId);

    if (res != null) {
      final list = res["data"]["comments"];
      return list.map((e) => CommentModel.fromJson(e)).toList();
    }
    return [];
  }

  // addComment
  Future<bool> addComment(int postId, String content) async {
    if (_token == null) return false;

    final res = await _apiService.addComment(_token!, postId, content);

    return (res != null && res["success"] == true);
  }

  //like
  Future<Map<String, dynamic>> fetchLikes(int postId) async {
    final res = await _apiService.fetchLikes(postId);

    return {
      "count": res?["data"]?["like_count"] ?? 1,
      "liked": res?["data"]?["liked"] ?? false,
    };
  }

  // toggle like
  Future<bool> toggleLike(int postId) async {
    if (_token == null) return false;

    final res = await _apiService.toggleLike(_token!, postId);
    return res != null;
  }

  //changePassword
  Future<Map<String, dynamic>> changePassword(
      String oldPass, String newPass) async {
    if (_token == null) return {"success": false};

    return await _apiService.changePassword(_token!, oldPass, newPass) ??
        {"success": false};
  }


  Future<bool> logout() async {
    if (_token == null) return false;

    _isLoading = true;
    notifyListeners();

    bool result = await _apiService.logout(_token!);

    _isLoading = false;

    if (result) {
      _token = null;
    }

    notifyListeners();
    return result;
  }
}

import 'package:http/http.dart';

class Product {
  bool? _success;
  String? _message;
  Data? _data;

  Product({bool? success, String? message, Data? data}) {
    if (success != null) {
      this._success = success;
    }
    if (message != null) {
      this._message = message;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  Product.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Posts>? _posts;
  Pagination? _pagination;

  Data({List<Posts>? posts, Pagination? pagination}) {
    if (posts != null) {
      this._posts = posts;
    }
    if (pagination != null) {
      this._pagination = pagination;
    }
  }

  List<Posts>? get posts => _posts;
  set posts(List<Posts>? posts) => _posts = posts;
  Pagination? get pagination => _pagination;
  set pagination(Pagination? pagination) => _pagination = pagination;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      _posts = <Posts>[];
      json['posts'].forEach((v) {
        _posts!.add(new Posts.fromJson(v));
      });
    }
    _pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._posts != null) {
      data['posts'] = this._posts!.map((v) => v.toJson()).toList();
    }
    if (this._pagination != null) {
      data['pagination'] = this._pagination!.toJson();
    }
    return data;
  }
}

class Posts {
  int? _id;
  String? _title;
  String? _excerpt;
  String? _content;
  String? _featuredImage;
  Author? _author;
  List<String>? _categories;
  int? _readTime;
  String? _createdAt;
  String? _updatedAt;
  String? _likeCount;
  String? _commentCount;
  bool? _isLiked;
  bool? _isBookmarked;



  Posts(
      {int? id,
        String? title,
        String? excerpt,
        String? content,
        String? featuredImage,
        Author? author,
        List<String>? categories,
        int? readTime,
        String? createdAt,
        String? updatedAt,
        String? likeCount,
        String? commentCount,
        bool? isLiked,
        bool? isBookmarked}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (excerpt != null) {
      this._excerpt = excerpt;
    }
    if (content != null) {
      this._content = content;
    }
    if (featuredImage != null) {
      this._featuredImage = featuredImage;
    }
    if (author != null) {
      this._author = author;
    }
    if (categories != null) {
      this._categories = categories;
    }
    if (readTime != null) {
      this._readTime = readTime;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (likeCount != null) {
      this._likeCount = likeCount;
    }
    if (commentCount != null) {
      this._commentCount = commentCount;
    }
    if (isLiked != null) {
      this._isLiked = isLiked;
    }
    if (isBookmarked != null) {
      this._isBookmarked = isBookmarked;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get excerpt => _excerpt;
  set excerpt(String? excerpt) => _excerpt = excerpt;
  String? get content => _content;
  set content(String? content) => _content = content;
  String? get featuredImage => _featuredImage;
  set featuredImage(String? featuredImage) => _featuredImage = featuredImage;
  Author? get author => _author;
  set author(Author? author) => _author = author;
  List<String>? get categories => _categories;
  set categories(List<String>? categories) => _categories = categories;
  int? get readTime => _readTime;
  set readTime(int? readTime) => _readTime = readTime;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get likeCount => _likeCount;
  set likeCount(String? likeCount) => _likeCount = likeCount;
  String? get commentCount => _commentCount;
  set commentCount(String? commentCount) => _commentCount = commentCount;
  bool? get isLiked => _isLiked;
  set isLiked(bool? isLiked) => _isLiked = isLiked;
  bool? get isBookmarked => _isBookmarked;
  set isBookmarked(bool? isBookmarked) => _isBookmarked = isBookmarked;

  Posts.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _excerpt = json['excerpt'];
    _content = json['content'];
    _featuredImage = json['featured_image'];

    _author = json['author'] != null
        ? Author.fromJson(json['author'])
        : null;

    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((cat) {
        if (cat is Map && cat.containsKey('name')) {
          _categories!.add(cat['name']);
        } else {
          _categories!.add(cat.toString());
        }
      });
    }

    _readTime = json['read_time'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];

    _likeCount = json['like_count']?.toString();
    _commentCount = json['comment_count']?.toString();

    _isLiked = json['is_liked'] == 1 || json['is_liked'] == true;
    _isBookmarked = json['is_bookmarked'] == 1 || json['is_bookmarked'] == true;
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['excerpt'] = this._excerpt;
    data['content'] = this._content;
    data['featured_image'] = this._featuredImage;
    if (this._author != null) {
      data['author'] = this._author!.toJson();
    }
    data['categories'] = this._categories;
    data['read_time'] = this._readTime;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['like_count'] = this._likeCount;
    data['comment_count'] = this._commentCount;
    data['is_liked'] = this._isLiked;
    data['is_bookmarked'] = this._isBookmarked;
    return data;
  }
}

class Author {
  int? _id;
  String? _name;
  String? _avatar;

  Author({int? id, String? name, String? avatar}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (avatar != null) {
      this._avatar = avatar;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get avatar => _avatar;
  set avatar(String? avatar) => _avatar = avatar;

  Author.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['avatar'] = this._avatar;
    return data;
  }
}

class Pagination {
  int? _currentPage;
  int? _perPage;
  int? _totalPosts;
  int? _totalPages;

  Pagination(
      {int? currentPage, int? perPage, int? totalPosts, int? totalPages}) {
    if (currentPage != null) {
      this._currentPage = currentPage;
    }
    if (perPage != null) {
      this._perPage = perPage;
    }
    if (totalPosts != null) {
      this._totalPosts = totalPosts;
    }
    if (totalPages != null) {
      this._totalPages = totalPages;
    }
  }

  int? get currentPage => _currentPage;
  set currentPage(int? currentPage) => _currentPage = currentPage;
  int? get perPage => _perPage;
  set perPage(int? perPage) => _perPage = perPage;
  int? get totalPosts => _totalPosts;
  set totalPosts(int? totalPosts) => _totalPosts = totalPosts;
  int? get totalPages => _totalPages;
  set totalPages(int? totalPages) => _totalPages = totalPages;

  Pagination.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    _perPage = json['per_page'];
    _totalPosts = json['total_posts'];
    _totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this._currentPage;
    data['per_page'] = this._perPage;
    data['total_posts'] = this._totalPosts;
    data['total_pages'] = this._totalPages;
    return data;
  }
}

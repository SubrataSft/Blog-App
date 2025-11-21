class PostModel {
  bool? success;
  String? message;
  Data? data;

  PostModel({this.success, this.message, this.data});

  PostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Posts>? posts;
  Pagination? pagination;

  Data({this.posts, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class Posts {
  int? id;
  String? title;
  String? excerpt;
  String? content;
  String? featuredImage;
  Author? author;
  List<String>? categories;
  int? readTime;
  String? createdAt;
  String? updatedAt;
  String? likeCount;
  String? commentCount;
  bool? isLiked;
  bool? isBookmarked;

  Posts(
      {this.id,
        this.title,
        this.excerpt,
        this.content,
        this.featuredImage,
        this.author,
        this.categories,
        this.readTime,
        this.createdAt,
        this.updatedAt,
        this.likeCount,
        this.commentCount,
        this.isLiked,
        this.isBookmarked});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    excerpt = json['excerpt'];
    content = json['content'];
    featuredImage = json['featured_image'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    categories = json['categories'] != null
        ? List<String>.from(json['categories'])
        : [];
    readTime = json['read_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likeCount = json['like_count'];
    commentCount = json['comment_count'];
    isLiked = json['is_liked'];
    isBookmarked = json['is_bookmarked'];
  }
}

class Author {
  int? id;
  String? name;
  String? avatar;

  Author({this.id, this.name, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }
}

class Pagination {
  int? currentPage;
  int? perPage;
  int? totalPosts;
  int? totalPages;

  Pagination({this.currentPage, this.perPage, this.totalPosts, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    totalPosts = json['total_posts'];
    totalPages = json['total_pages'];
  }
}

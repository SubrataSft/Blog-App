import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../model/product_model.dart';
import '../details_screen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  late Future<List<Posts>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts(perPage: 1000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        title: const Text(
          'Blog',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.search, color: Colors.white, size: 30),
          SizedBox(width: 16),
        ],
      ),

      body: FutureBuilder<List<Posts>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final posts = snapshot.data ?? [];

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(post: post,),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1E),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title ?? "No Title",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              post.excerpt ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          post.featuredImage ?? "",
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,

                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// API URL
String baseUrl = "https://api.zhndev.site/wp-json/blog-app/v1/posts";

Future<List<Posts>> fetchPosts({int page = 1, int perPage = 1000}) async {
  try {
    final response = await http.get(Uri.parse("$baseUrl?page=$page&per_page=$perPage"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      Product product = Product.fromJson(jsonData);

      return product.data?.posts ?? [];
    } else {
      throw Exception("Failed to load posts: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}

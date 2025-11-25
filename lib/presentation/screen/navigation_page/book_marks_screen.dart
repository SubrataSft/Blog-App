import 'package:flutter/material.dart';
import '../../../model/model.dart';
import '../../../model/provider/provider.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  final authProvider = AuthProvider();

  List<Posts> allPosts = [];
  List<Posts> filteredPosts = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    allPosts = await authProvider.showPosts();
    filteredPosts = allPosts;
    setState(() => loading = false);
  }

  void searchPosts(String text) {
    text = text.toLowerCase();
    filteredPosts = allPosts.where((post) {
      return (post.title ?? "").toLowerCase().contains(text) ||
          (post.content ?? "").toLowerCase().contains(text);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        title: Text(
          "Books",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    onChanged: searchPosts,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      final p = filteredPosts[index];
                      return Card(
                        color: const Color(0xFF1A1A1E),
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              p.featuredImage ?? "",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            p.title ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            p.content ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}



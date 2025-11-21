import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/comments_model.dart';
import '../../model/provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final dynamic post;

  const DetailsScreen({super.key, required this.post});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late AuthProvider authProvider;

  List<CommentModel> comments = [];
  bool loadingComments = true;

  final TextEditingController commentController = TextEditingController();

  int likesCount = 0;
  bool likedByUser = false;
  bool loadingLikes = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authProvider = Provider.of<AuthProvider>(context, listen: false);
      fetchInitialData();
    });
  }

  Future<void> fetchInitialData() async {
    await Future.wait([
      loadComments(),
      loadLikes(),
    ]);
  }

  Future<void> loadComments() async {
    comments = await authProvider.showComments(widget.post.id ?? 0);
    setState(() => loadingComments = false);
  }

  Future<void> submitComment() async {
    if (commentController.text.trim().isEmpty) return;

    final success = await authProvider.addComment(
      widget.post.id ?? 0,
      commentController.text.trim(),
    );

    if (success) {
      commentController.clear();
      loadComments();
    }
  }

  Future<void> loadLikes() async {
    final data = await authProvider.fetchLikes(widget.post.id ?? 0);
    setState(() {
      likesCount = data['count'];
      likedByUser = data['liked'];
      loadingLikes = false;
    });
  }

  Future<void> toggleLike() async {
    final success = await authProvider.toggleLike(widget.post.id ?? 0);

    if (success) {
      setState(() {
        likedByUser = !likedByUser;
        likesCount += likedByUser ? 1 : -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  // -----------------------------
  // APPBAR
  // -----------------------------
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      actions: const [
        Icon(Icons.bookmark_add_outlined, color: Colors.white, size: 30),
        SizedBox(width: 16),
      ],
    );
  }

  // -----------------------------
  // BODY
  // -----------------------------
  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(),
          const SizedBox(height: 16),
          buildTitle(),
          const SizedBox(height: 12),
          buildContent(),
          const SizedBox(height: 20),
          buildLikesAndCommentsRow(),
          const SizedBox(height: 25),
          buildCommentsHeader(),
          const SizedBox(height: 8),
          buildCommentsSection(),
          const SizedBox(height: 20),
          buildCommentInputBox(),
        ],
      ),
    );
  }

  // -----------------------------
  // IMAGE
  // -----------------------------
  Widget buildImage() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Image.network(
        widget.post.featuredImage ?? "",
        fit: BoxFit.cover,
      ),
    );
  }

  // -----------------------------
  // TITLE
  // -----------------------------
  Widget buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        widget.post.title ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // -----------------------------
  // CONTENT
  // -----------------------------
  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        widget.post.content ?? "",
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          height: 1.4,
        ),
      ),
    );
  }

  // -----------------------------
  // LIKE + COMMENT ROW
  // -----------------------------
  Widget buildLikesAndCommentsRow() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: toggleLike,
              icon: Icon(
                likedByUser ? Icons.favorite : Icons.favorite_border,
                color: likedByUser ? Colors.red : Colors.white,
                size: 30,
              ),
            ),
            if (!loadingLikes)
              Positioned(
                right: 4,
                top: 8,
                child: buildCountBadge(likesCount),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.comment, color: Colors.white, size: 28),
            Positioned(
              right: 4,
              top: 8,
              child: buildCountBadge(comments.length),
            ),
          ],
        ),
      ],
    );
  }

  // Badge UI
  Widget buildCountBadge(int number) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: Text(
        number.toString(),
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }

  // -----------------------------
  // COMMENTS HEADER
  // -----------------------------
  Widget buildCommentsHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        "Comments",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // -----------------------------
  // COMMENTS LIST
  // -----------------------------
  Widget buildCommentsSection() {
    if (loadingComments) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.orange),
      );
    }

    if (comments.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "No comments yet",
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      itemCount: comments.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        final c = comments[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(c.user, style: const TextStyle(color: Colors.white)),
          subtitle: Text(c.comment, style: const TextStyle(color: Colors.white70)),
        );
      },
    );
  }

  // -----------------------------
  // COMMENT INPUT BOX
  // -----------------------------
  Widget buildCommentInputBox() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Write a comment...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: submitComment,
            icon: const Icon(Icons.send, color: Colors.orange, size: 28),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_dom/apiUtils/apiheloer/apihelper.dart';
import 'package:project_dom/apiUtils/model/post.dart';
// Your Post model

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API CRUD',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PostListScreen(),
    );
  }
}
// Your Post model

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late ApiService apiService;
  late Future<List<Post>> postList;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    postList = apiService.fetchPosts();
  }

  // Method to show the Create Post dialog
  void _showCreatePostDialog(Post? post) {
    final _titleController = TextEditingController(text: post != null? post.title : '');
    final _bodyController = TextEditingController( text: post != null? post.body : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text( post != null? 'Update Post' : 'Create New Post'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _bodyController,
                  decoration: InputDecoration(labelText: 'Body'),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedPost = Post(
                  id: post?.id,
                  title: _titleController.text,
                  body: _bodyController.text,
                );

                if (_titleController.text.isNotEmpty &&
                    _bodyController.text.isNotEmpty) {
                  try {
                    if (post != null) {
                      final updatedPost2 = await apiService.updatePost(updatedPost);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Post Updated: ${updatedPost2.title}'),
                        ),
                      );
                      setState(() {
                        postList =
                            apiService.fetchPosts(); // Refresh the posts list
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    } else {
                      final createdPost2 = await apiService.createPost(updatedPost);
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Post Created: ${createdPost2.title}'),
                        ),
                      );
                      setState(() {
                        postList =
                            apiService.fetchPosts(); // Refresh the posts list
                      });
                      Navigator.of(context).pop();
                    }
                    // Close the dialog
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to create post: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in both fields')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreatePostDialog(null),

            // onPressed: _showCreatePostDialog,
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: postList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available.'));
          }

          List<Post> postsData = snapshot.data!;

          return ListView.builder(
            itemCount: postsData.length,
            itemBuilder: (context, index) {
              Post post = postsData[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                onTap: () {
                  // Example of Update
                  Post updatedPost = Post(
                    id: post.id,
                    title: post.title,
                    body: post.body,
                  );

                  _showCreatePostDialog(updatedPost);
                  // await apiService.updatePost(updatedPost);
                  // setState(() {
                  //   postList =
                  //       apiService.fetchPosts(); // Refresh the posts list
                  // });
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await apiService.deletePost(post.id);
                    setState(() {
                      postList =
                          apiService.fetchPosts(); // Refresh the posts list
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
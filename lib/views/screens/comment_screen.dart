import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/controllers/comment_controller.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatefulWidget {
  final String id;
  const CommentScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CommentController _commentController = Get.put(CommentController());
  final TextEditingController _commentTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _commentController.updatePostId(widget.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _commentController.comments.length,
                  itemBuilder: (context, i) {
                    final comment = _commentController.comments[i];
                    return ListTile(
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                          imageUrl: comment.profilePhoto,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.username,
                            style: const TextStyle(
                              fontSize: 16,
                              color: purpleColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            comment.comment,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            tago.format(comment.datePublished.toDate()),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${comment.likes.length} likes',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                          onTap: () =>
                              _commentController.likeComment(comment.userId),
                          child: Column(
                            children: [
                              const SizedBox(height: 3),
                              Icon(
                                Icons.favorite,
                                size: 25,
                                color: comment.likes
                                        .contains(authController.user.uid)
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${comment.likes.length}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ),
            const Divider(),

            ListTile(
              title: Row(
                children: [
                  ClipOval(
                      child: CachedNetworkImage(
                          width: 40,
                          fit: BoxFit.cover,
                          height: 40,
                          imageUrl:
                              authController.currentUserProfilePhoto.value)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _commentTextController,
                      decoration: const InputDecoration(
                        hintText: 'Comment...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _commentController
                          .postComment(_commentTextController.text);
                      setState(() {
                        _commentTextController.text = '';
                      });
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: purpleColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ListTile(
            //   title: TextFormField(
            //     controller: _commentTextController,
            //     style: const TextStyle(
            //       fontSize: 16,
            //       color: Colors.white,
            //     ),
            //     decoration: InputDecoration(
            //       hintText: 'Comment',
            //       filled: true,
            //       border: OutlineInputBorder(
            //           borderSide: Divider.createBorderSide(context)),
            //       enabledBorder: OutlineInputBorder(
            //           borderSide: Divider.createBorderSide(context)),
            //       focusedBorder: OutlineInputBorder(
            //           borderSide: Divider.createBorderSide(context)),
            //     ),
            //   ),
            //   trailing: TextButton(
            //     child: const Text(
            //       'Send',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 16,
            //       ),
            //     ),
            //     onPressed: () {
            //       _commentController.postComment(_commentTextController.text);
            //       setState(() {
            //         _commentTextController.text = '';
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

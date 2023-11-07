import 'package:appcoffeeshop/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/auth_token.dart';

class CommentService extends FirebaseService {
  late final CollectionReference<Map<String, dynamic>> commentProducts;

  CommentService([AuthToken? authToken]) : super(authToken) {
    commentProducts = getCommentProducts();
  }

  Future<void> addComment(
    String idProduct,
    String idUser,
    String idCreator,
    String content,
  ) async {
    await commentProducts.doc(idProduct).get().then((value) async {
      if (value.exists) {
        await commentProducts.doc(idProduct).update({
          'comment': FieldValue.arrayUnion(
            [
              {'userCommentId': idUser, 'content': content}
            ],
          ),
        });
      } else {
        await commentProducts.doc(idProduct).set({
          'idCreator': idCreator,
          'comment': FieldValue.arrayUnion(
            [
              {'userCommentId': idUser, 'content': content}
            ],
          ),
        });
      }
    });
  }

  Future<List<String>> fetchComments(String id) async {
    List<String> data = [];
    await commentProducts.doc(id).get().then((value) {
      var comments = (value['comment'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>)['content'] as String)
          .toList();
      data.addAll(comments);
    });
    return data;
  }
}

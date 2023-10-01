import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Models/ChatModel.dart';
import '../controllers/loading.dart';
import '../screens/snackbar.dart';
import 'Authentication.dart';
class ChatServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sendMessage({ required String name, required String content,required String groupChatId}) async {
    try {
      var x = firestore.collection("rooms").doc('$groupChatId').collection('chat')
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      ChatModel chat = ChatModel(idFrom: FirebaseAuth.instance.currentUser?.uid,name: name,timestamp: DateTime.now().toString(),content: content);
      x.set(chat.toJson()).then((value) => print('done'));
    } catch (e) {
      loading(false);
      alertSnackbar("Can't add Item");
    }
  }
  Stream<List<ChatModel>>? streamAllMessages(String roomId) {
    try {
      return firestore.collection("rooms").doc('$roomId').collection('chat').snapshots().map((event) {
        loading(false);
        List<ChatModel> list = [];
        event.docs.forEach((element) {
          final admin = ChatModel.fromJson(element.data());
          print(admin.content);
          list.add(admin);
        });
        loading(false);
        return list;
      });

    }catch(e){
      print(e);
      return  null;
    }
  }
}



import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{

  late final String to;
  late final String from;
  late final bool isFromMe;
  late final String message;
  Timestamp? date;

  MessageModel({required this.to,required this.from,required this.isFromMe,required this.message, this.date});

  Map<String,dynamic> toMap(){
    return {
      'to' : to,
      'from' : from,
      'isFromMe' : isFromMe,
      'message' : message,
      'date' : date ?? FieldValue.serverTimestamp(),
    };
  }

  MessageModel.fromMap(Map <String,dynamic> userModelMap){
    to = userModelMap['to'];
    from = userModelMap['from'];
    isFromMe = userModelMap['isFromMe'];
    message = userModelMap['message'];
    date = userModelMap['date'];
  }


}
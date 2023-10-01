import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? parkedOn;
  String? contactNo;
  bool? isParked;
  String? carNo;
  String? parkedUpto;

  UserModel(
      {this.name,
        this.email,
        this.parkedOn,
        this.contactNo,
        this.uid,
        this.isParked,
        this.carNo,
        this.parkedUpto
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    parkedOn = json['registeredOn'];
    contactNo = json['contactNo'];
    uid = json['uid'];
    isParked =json['isParked'];
    carNo = json['carNo'];
    parkedUpto = json['parkedUpto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['registeredOn'] = this.parkedOn;
    data['contactNo'] = this.contactNo;
    data['uid'] = this.uid;
    data['carNo'] = this.carNo;
    data['isParked'] = this.isParked;
    data['parkedUpto'] = this.parkedUpto;
    return data;
  }
}

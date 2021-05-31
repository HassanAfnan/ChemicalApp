import 'package:cloud_firestore/cloud_firestore.dart';

class TankModel{
  String id;
  double ammonia;
  String date;
  String email;
  double feed;
  double nitrate;
  double nitrite;
  double ph;
  double tds;
  double weight;

  TankModel(
      this.id,
      this.ammonia,
      this.date,
      this.email,
      this.feed,
      this.nitrate,
      this.nitrite,
      this.ph,
      this.tds,
      this.weight
      );
}
import 'package:flutter/material.dart';

class Landmark {
  final String image, title;
  final int size, id;
  final Color color;
  Landmark({
    this.id,
    this.image,
    this.title,
    this.size,
    this.color,
  });
}

List<Landmark> landmark = [
  Landmark(
      id: 1,
      title: "Taj Mahal",
      image: "assets/TajMahal.png",
      color: Color(0xFF3D82AE)),
  Landmark(
      id: 2,
      title: "Qutub Minar",
      image: "assets/QutubMinar.png",
      color: Color(0xFFD3A984)),
  Landmark(
      id: 3,
      title: "Lotus Temple",
      image: "assets/lotus.png",
      color: Color(0xFF989493)),
  Landmark(
      id: 4,
      title: "Gateway of India",
      image: "assets/gatewayindia.png",
      color: Color(0xFFE6B398)),
  Landmark(
      id: 5,
      title: "Charminar",
      image: "assets/charminar.png",
      color: Color(0xFFFB7883)),
  Landmark(
      id: 6,
      title: "Redfort",
      image: "assets/redfort.png",
      color: Color(0xFFAEAEAE)),
];
String dummyText = "Lorem Ipsum Lorem Ipsum Lorem Ipsum";

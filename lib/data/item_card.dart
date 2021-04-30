import 'package:flutter/material.dart';
import 'constraints.dart';
import 'products.dart';


class ItemCard extends StatelessWidget {
  final Landmark landm;
  final Function press;
  const ItemCard({
    this.landm,
    this.press,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child:Image.asset(landm.image),
              padding: EdgeInsets.all(kDefaultPadding),
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                  color: landm.color,
                  borderRadius: BorderRadius.circular(16.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child:
                Text(landm.title, style: TextStyle(color: kTextLightColor)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'constraints.dart';
import 'products.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            "Discover India",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.builder(
              itemCount: landmark.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: kDefaultPadding,
                  crossAxisSpacing: kDefaultPadding),
              itemBuilder: (context, index) =>
                  ItemCard(landm: landmark[index])),
        ),
      ],
    );
  }
}

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
    return Column(
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
    );
  }
}

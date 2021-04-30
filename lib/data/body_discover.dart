import 'package:flutter/material.dart';
import 'package:voyage/data/details/details.dart';
import 'constraints.dart';
import 'products.dart';
import 'item_card.dart';

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
                  ItemCard(landm: landmark[index],press: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(landm: landmark[index]))),)),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:voyage/data/products.dart';
import 'body_details.dart';
import 'package:voyage/data/constraints.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.landm,
  }) : super(key: key);

  final Landmark landm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            landm.title,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: Image.asset(landm.image, fit: BoxFit.fill),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

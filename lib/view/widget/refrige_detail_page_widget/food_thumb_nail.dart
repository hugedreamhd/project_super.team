import 'package:flutter/material.dart';

import '../../../data/models/foods_model.dart';

class FoodThumbNail extends StatelessWidget {
  const FoodThumbNail(
      {super.key,
      required this.foodItem,
      required this.period,
      required this.extendPeriod});

  final int period;
  final int extendPeriod;
  final FoodDetail foodItem;

  @override
  Widget build(BuildContext context) {
    int passedDate = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(foodItem.registerDate))
        .inDays;
    int remainPeriod = period - passedDate;
    if (foodItem.isExtended == true) {
      remainPeriod += extendPeriod;
    }
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(40),
            )),
            child: Image.network(
              foodItem.foodImage,
              height: 40,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('주인장: ${foodItem.userName}'),
                  Text('남은날: $remainPeriod')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

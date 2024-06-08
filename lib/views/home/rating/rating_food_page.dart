import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glaz/controllers/rating_controller.dart';

class RatingFoodPage extends StatefulWidget {
  final String productId;

  const RatingFoodPage({Key? key, required this.productId}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingFoodPage> {
  final RatingController ratingController = Get.put(RatingController());
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donner une note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Donnez une note pour ce produit',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _currentRating ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _currentRating = index + 1;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final rating = RatingModel(
                  ratingType: 'Food',
                  product: widget.productId,
                  rating: _currentRating,
                );
                await ratingController.postRating(rating);
                Get.back();
              },
              child: Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/models/order_model.dart';
import 'package:glaz/views/order/itemId.dart';
import 'package:lottie/lottie.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: "Détails de ma commande",
          style: appStyle(18, kTertiary, FontWeight.w600),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: kLightWhite, // Couleur de fond du conteneur
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ListTile(
                title: ReusableText(
                  text: " G L A Z ",
                  style: appStyle(20, kTertiary, FontWeight.bold),
                ),
              ),
              ListTile(
                title: ReusableText(
                  text: 'Total: ${order.orderTotal} \DH',
                  style: appStyle(20, kTertiary, FontWeight.bold),
                ),
              ),
              Divider(),
              for (var item in order.orderItems) _buildOrderItemTile(item),
            ],
          ),
        ),
      ),
    );
  }

  int orderIndex =
      0; // Variable pour garder une trace de l'index de la commande

  Widget _buildOrderItemTile(OrderItem item) {
    final ItemId? itemDetails =
        item.foodId ?? item.dessertId ?? item.commencerId;

    orderIndex++; // Incrémentez l'index de la commande à chaque fois que vous traitez un nouvel élément

    return Column(
      children: [
        Card(
          elevation: 2, // Élévation de la carte pour un aspect tridimensionnel
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: itemDetails != null && itemDetails.imageUrl.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      itemDetails.imageUrl[0],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox.shrink(),
            title: Text(itemDetails?.title ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantité: ${item.quantity}'),
                Text('Préférences: ${item.instructions}'),
                Text('Additifs: ${item.additives.join(', ')}'),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: 320.w,
            height: 400.h,
            child: Lottie.asset("assets/anime/cook.json"),
          ),
        ),
      ],
    );
  }
}

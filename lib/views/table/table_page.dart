import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/hooks/fetch_tables.dart';
import 'package:glaz/views/table/reservation_detaile.dart';

class TableSelectionPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final fetchHook = useFetchTables();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sélectionner une Table',
          style: appStyle(16, kLightWhite, FontWeight.bold),
        ),
        backgroundColor: kTertiary,
      ),
      backgroundColor: kTertiary,
      body: fetchHook.isLoading
          ? Center(child: CircularProgressIndicator())
          : fetchHook.data != null
              ? ListView(
                  children: fetchHook.data!.map((table) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                table.profileImage,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Table ${table.tableNumber}',
                              style: appStyle(18, kDark, FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => TableDetailPage(
                                      table: table,
                                    ));
                              },
                              child: Text('Voir les détails'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              : Center(
                  child: Text(
                    'Erreur lors de la récupération des tables',
                    style: appStyle(16, kDark, FontWeight.w500),
                  ),
                ),
    );
  }
}

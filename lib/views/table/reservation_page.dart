import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glaz/common/custom_buton.dart';
import 'package:glaz/controllers/reservation_controller.dart';
import 'package:glaz/models/login_response.dart';
import 'package:glaz/models/reservation_model.dart';
import 'package:glaz/models/table_model.dart';
import 'package:glaz/common/app_style.dart';
import 'package:glaz/common/reusable_text.dart';
import 'package:glaz/constants/constants.dart';
import 'package:glaz/views/entrypoint.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/login_Controller.dart';

class ReservationPage extends StatefulWidget {
  final TableModel table;

  ReservationPage({required this.table});

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  LoginRespnse? user;
  DateTime? selectedDateTime;
  int numberOfPersons = 1;

  @override
  void initState() {
    super.initState();
    final loginController = Get.put(LoginController());
    user = loginController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final ReservationController reservationController =
        Get.put(ReservationController());
    return Scaffold(
      backgroundColor: kTertiary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kTertiary,
        title: Center(
          child: ReusableText(
            text: 'GLAZ Réservation',
            style: appStyle(18, kLightWhite, FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(height: 20.h),
          Lottie.asset(
            'assets/anime/cook.json',
            height: 200.h,
          ),
          SizedBox(height: 20.h),
          ReusableText(
            text: 'Sélectionnez le temps de réservation',
            style: appStyle(18, kDark, FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              _showDatePicker();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: kLightWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.time, color: kTertiary),
                  SizedBox(width: 10.w),
                  selectedDateTime == null
                      ? ReusableText(
                          text: 'Choisissez le temps',
                          style: appStyle(16, kTertiary, FontWeight.w400),
                        )
                      : ReusableText(
                          text:
                              '${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} ${selectedDateTime!.hour}:${selectedDateTime!.minute}',
                          style: appStyle(16, kDark, FontWeight.w600),
                        ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          ReusableText(
            text: 'Nombre de personnes',
            style: appStyle(18, kDark, FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          CupertinoTextField(
            keyboardType: TextInputType.number,
            placeholder: 'Nombre de personnes',
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                numberOfPersons = int.tryParse(value) ?? 1;
              });
            },
            style: appStyle(16, kDark, FontWeight.w400),
            decoration: BoxDecoration(
              color: kLightWhite,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            text: 'Confirmer la réservation',
            btnHeight: 45.h,
            onTap: () {
              if (selectedDateTime != null && numberOfPersons > 0) {
                if (user != null) {
                  ReservationModel reservation = ReservationModel(
                    tableId: widget.table.id,
                    userId: user!.id,
                    tableNumber: widget.table.tableNumber,
                    reservationTime: selectedDateTime!,
                    numberOfPersons: numberOfPersons,
                  );

                  reservationController
                      .createReservation(reservation)
                      .then((_) {
                    Get.offAll(() =>
                        MainScreen()); // Remplacez par la route réelle de votre écran principal
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Utilisateur non connecté')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Veuillez remplir tous les champs')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}

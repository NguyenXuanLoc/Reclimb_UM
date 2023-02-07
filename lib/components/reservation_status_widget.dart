import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class ReservationStatusWidget extends StatefulWidget {
  const ReservationStatusWidget({Key? key}) : super(key: key);

  @override
  State<ReservationStatusWidget> createState() =>
      _ReservationStatusWidgetState();
}

class _ReservationStatusWidgetState extends State<ReservationStatusWidget>
    with TickerProviderStateMixin {
  late AnimationController statusReservationController;

  @override
  void initState() {
    statusReservationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..addListener(() => setState(() {}));
    statusReservationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: LinearProgressIndicator(
        minHeight: 2.5,
        value: statusReservationController.value,
        color: const Color(0xff42AB06),
        backgroundColor: colorText0.withOpacity(0.38),
      ),
    );
  }
}

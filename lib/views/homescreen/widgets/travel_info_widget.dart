import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jorney_map/consts/app_colors.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';

import '../../../data/model/travel_model.dart';
import '../../flight_detail/views/flight_details_screen.dart';

class TravelInfoWidget extends StatelessWidget {
  final TravelModel travelModel;

  TravelInfoWidget({required this.travelModel});
  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.01,
              ),
              Column(
                children: [
                  Text(travelModel.departureInfo.country),
                  Text(travelModel.departureInfo.city)
                ],
              ),
              Spacer(),
              Image.asset('assets/images/flight.png'),
              Spacer(),
              Column(
                children: [
                  Text(travelModel.arrivalInfo.country),
                  Text(travelModel.arrivalInfo.city)
                ],
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.01,
            ),
            Image.asset('assets/images/dots.png'),
            SizedBox(
              width: size.width * 0.025,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/images/departure.svg'),
                SizedBox(
                  height: size.width * 0.01,
                ),
                SvgPicture.asset('assets/images/arrival.svg'),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text(_formatDate(travelModel.departureInfo.date)),
                SizedBox(
                  height: size.width * 0.015,
                ),
                Text(_formatDate(travelModel.departureInfo.date)),
              ],
            ),
            SizedBox(
              width: size.width * 0.025,
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/book.svg'),
              Text('Plans'),
              Spacer(),
              Text('2 plans'),
              SvgPicture.asset('assets/icons/arrow.svg'),
            ],
          ),
        ),
        ChosenActionButton(
          text: 'See flight details',
          color: AppColors.redColor.withOpacity(0.14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FlightDetailsScreen(travelModel: travelModel),
              ),
            );
          },
        ),
      ],
    );
  }
}

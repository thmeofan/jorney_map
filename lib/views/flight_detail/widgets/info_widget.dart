import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/consts/app_colors.dart';

class InfoWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String city;
  final String country;
  final String date;
  final String time;
  final String airport;

  InfoWidget({
    required this.iconPath,
    required this.title,
    required this.city,
    required this.country,
    required this.date,
    required this.time,
    required this.airport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                color: AppColors.redColor,
              ),
              SizedBox(width: 8.0),
              Text(title),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text('$city, $country'),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: '),
                  Text(date),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time: '),
                  Text(time),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Airport: '),
                  Text(airport),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_application_1/style/colors.dart';
import 'package:flutter_application_1/style/style.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Dashboard',
              //   style: Theme.of(context).textTheme.headlineSmall,
              //),
              PrimaryText(
                  text: 'Dashboard', size: 24, fontWeight: FontWeight.w600),
              PrimaryText(
                text: 'Student',
                size: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
              )
            ]),
      ),
      Spacer(
        flex: 2,
      ),
      Expanded(
        flex: Responsive.isDesktop(context) ? 1 : 3,
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              contentPadding: EdgeInsets.only(left: 40.0, right: 5),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.white),
              ),
              prefixIcon: Icon(Icons.search, color: AppColors.black),
              hintText: 'Search',
              hintStyle: TextStyle(color: AppColors.secondary, fontSize: 14)),
        ),
      ),
    ]);
  }
}

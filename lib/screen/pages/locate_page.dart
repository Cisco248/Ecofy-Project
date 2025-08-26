import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:e_wms_mobile/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class LocateBinPage extends StatefulWidget {
  const LocateBinPage({super.key});

  @override
  State<LocateBinPage> createState() => _LocateBinPageState();
}

class _LocateBinPageState extends State<LocateBinPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: LocateBottom());
  }
}

class LocateBottom extends StatelessWidget {
  const LocateBottom({super.key});

  @override
  Widget build(BuildContext context) {
    double boxSize = 16;
    double spaceSize1 = 5;
    double spaceSize2 = 30;
    var errorColor = AppColors.error;
    var successColor = AppColors.success;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(50),
          topStart: Radius.circular(50),
        ),
      ),
      height: AppSizeStyle.locateBottomHeight(context),
      width: AppSizeStyle.locateBottomWidth(context),
      child: Column(
        spacing: spaceSize2,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                spacing: spaceSize1,
                children: [
                  Container(
                    height: boxSize,
                    width: boxSize,
                    decoration: BoxDecoration(
                      color: errorColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Text(
                    'Out of Storage',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                spacing: spaceSize1,
                children: [
                  Container(
                    height: boxSize,
                    width: boxSize,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Text(
                    'Remaining Storage',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nearest Garbage Bin',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Nearest Status',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '1.0 Km',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Remaining',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:travel_smartapp/config/constatnts.dart';
import 'package:travel_smartapp/domain/cloud_services/station_service.dart';
import 'package:travel_smartapp/domain/models/station_mode.dart';
import 'package:travel_smartapp/extentions/context/themes.dart';
import 'package:travel_smartapp/widgets/appbar/material_appbar.dart';
import 'package:travel_smartapp/widgets/divider/dashed_divider.dart';

class BookingCode extends StatelessWidget {
  const BookingCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "ID 743650898"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBookingCard(context),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: kPadding),
          //   child: Text(
          //     "Train Route",
          //     style:
          //         TextStyle(fontSize: kFontSize, fontWeight: FontWeight.w500),
          //   ),
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Column(
          //         children: const [
          //           Padding(
          //             padding: EdgeInsets.all(8.0),
          //             child: Text("Text1"),
          //           ),
          //           Padding(
          //             padding: EdgeInsets.all(8.0),
          //             child: Text("Text1"),
          //           )
          //         ],
          //       ),
          //     ),
          //     Column(
          //       children: [
          //         Container(
          //           width: 10,
          //           height: 10,
          //           decoration: const BoxDecoration(
          //               color: Colors.orange, shape: BoxShape.circle),
          //         ),
          //         const SizedBox(
          //           height: 50,
          //           child: VerticalDivider(
          //             thickness: 1.0,
          //             width: 10,
          //             color: Colors.black12,
          //           ),
          //         ),
          //         Container(
          //           width: 10,
          //           height: 10,
          //           decoration: const BoxDecoration(
          //               color: Colors.orange, shape: BoxShape.circle),
          //         ),
          //       ],
          //     ),
          //     Expanded(
          //       child: Column(
          //         children: const [
          //           Padding(
          //             padding: EdgeInsets.all(8.0),
          //             child: Text("Text1"),
          //           ),
          //           Padding(
          //             padding: EdgeInsets.all(8.0),
          //             child: Text("Text1"),
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  Widget buildBookingCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kPadding),
      padding: const EdgeInsets.all(kPadding * 1.1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: kPrimaryColor,
      ),
      child: ClipPath(
        clipper: DolDurmaClipper(holeRadius: 30, bottom: 70 + kPadding),
        child: Container(
          padding: const EdgeInsets.all(kPadding * 0.8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius / 2),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const Text("Ruhunu Kumari",
                  style: TextStyle(
                    fontSize: kFontSize,
                    fontWeight: FontWeight.w500,
                  )),
              const Text("Express Train",
                  style: TextStyle(
                    fontSize: kFontSize * .6,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  )),
              buildRoute(),
              //const SizedBox(height: kPadding),
              ...{
                "Full Name": "Alwis Gunarathne",
                "Date": "18 April",
                "Arrival Time": "12:10",
                "Executive": "1",
                "Seat": "8A"
              }
                  .entries
                  .map((e) => cardInfo(leading: e.key, traling: e.value))
                  .toList(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: kPadding),
                child: DashedDivider(dash: 50, color: kPrimaryColor),
              ),
              SizedBox(
                height: 70,
                child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: '743650898',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardInfo({required String leading, required String traling}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPadding * .1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leading,
            style: const TextStyle(color: Colors.black54),
          ),
          Text(traling),
        ],
      ),
    );
  }

  Widget buildRoute() {
    return Row(
      children: [
        Expanded(
          child: _buildRouteStation(
            label: "From",
            text: "Galle",
          ),
        ),
        Expanded(
          child: _buildRouteStation(
            label: "To",
            text: "Colombo",
          ),
        )
      ],
    );
  }

  Container _buildRouteStation({required String label, required String text}) {
    return Container(
      // alignment: Alignment.center,
      padding: const EdgeInsets.all(kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: kFontSize * .5,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: kFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: kPadding * .3),
            child: Text(
              "Wed April 1 12:20",
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  DolDurmaClipper({required this.bottom, required this.holeRadius});

  final double bottom;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0.0, size.height - bottom - holeRadius)
      ..arcToPoint(
        Offset(0, size.height - bottom),
        clockwise: true,
        radius: const Radius.circular(1),
      )
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - bottom)
      ..arcToPoint(
        Offset(size.width, size.height - bottom - holeRadius),
        clockwise: true,
        radius: const Radius.circular(1),
      );

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}

import 'package:agri_hack/screens/scan_screen.dart';
import 'package:agri_hack/widgets/discover_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/discover_small_card.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  String location = "Loading";
  String temperature = "Loading";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w, top: 40.w),
              child: Text("Hey There 👋",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.w,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 30.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DiscoverCard(
                      tag: "scan card",
                      gradientStartColor: const Color(0xffff512f),
                      gradientEndColor: const Color(0xffdd2476),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScreenScan()));
                      },
                      title: "Scan Soil",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Regional Services",
                      style: TextStyle(
                          color: Color(0xff515979),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.w),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 120.h,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          DiscoverSmallCard(
                            gradientStartColor: const Color(0xff13DEA0),
                            gradientEndColor: const Color(0xff06B782),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ScreenScan()));
                            },
                            title: "Krishibhavan",
                            subtitle: "${location}",
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          DiscoverSmallCard(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ScreenScan()));
                            },
                            title: "Weather",
                            subtitle: "${temperature}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Market Today",
                      style: TextStyle(
                          color: Color(0xff515979),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.w),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        height: 200.h,
                        width: 300.w,
                        child: ListView.separated(
                            itemBuilder: (context, index) => const Text(
                                  "Some Fertilizer : ₹100",
                                  style: TextStyle(color: Colors.white),
                                ),
                            separatorBuilder: (context, index) => const Divider(
                                  color: Colors.blueGrey,
                                ),
                            itemCount: 10))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

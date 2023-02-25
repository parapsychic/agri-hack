import 'package:agri_hack/models/measures.dart';
import 'package:agri_hack/services/rest_services.dart';
import 'package:agri_hack/widgets/discover_small_card.dart';
import 'package:agri_hack/widgets/icons.dart';
import 'package:agri_hack/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenScan extends StatefulWidget {
  const ScreenScan({super.key});

  @override
  State<ScreenScan> createState() => _ScreenScanState();
}

class _ScreenScanState extends State<ScreenScan> {
  //TODO make this to class
  Measures _measures = Measures();
  bool _isLoading = false;

  @override
  initState() {
    super.initState();
    _refresh();
  }

  _refresh() async {
    print("Starting refresh");
    setState(() {
      _isLoading = true;
    });
    final valuesNew = await RESTServices.getValues();

    setState(() {
      _measures.n = valuesNew.measures.n;
      _measures.p = valuesNew.measures.p;
      _measures.k = valuesNew.measures.k;
      _measures.pH = valuesNew.measures.pH;
      _measures.temperature = valuesNew.measures.temperature;
      _measures.moisture = valuesNew.measures.moisture;
      _isLoading = false;
    });
  }

  _refreshSingle(int pin) async {
    final valuesNew = await RESTServices.getSingleValue(pin);
    setState(() {
      switch (pin) {
        case 0:
          _measures.n = valuesNew[1];
          break;
        case 1:
          _measures.p = valuesNew[1];
          break;
        case 2:
          _measures.k = valuesNew[1];
          break;
        case 3:
          _measures.pH = valuesNew[1];
          break;
        case 4:
          _measures.temperature = valuesNew[1];
          break;
        case 5:
          _measures.moisture = valuesNew[1];
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      //backgroundColor: Color.fromARGB(255, 7, 36, 6),
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff121421),
      ),
      body: SafeArea(
          child: !_isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 28.w, top: 40.w),
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
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: Center(
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 19.w,
                                  mainAxisExtent: 125.w,
                                  mainAxisSpacing: 19.w),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            DiscoverSmallCard(
                              onTap: () {
                                _refreshSingle(0);
                              },
                              title: "Nitrogen",
                              subtitle: "${_measures.n}",
                              gradientStartColor: const Color(0xff13DEA0),
                              gradientEndColor: const Color(0xff06B782),
                            ),
                            DiscoverSmallCard(
                              onTap: () {},
                              title: "Phosphorous",
                              subtitle: "${_measures.p}",
                              gradientStartColor: const Color(0xffFC67A7),
                              gradientEndColor: const Color(0xffF6815B),
                              icon: SvgAsset(
                                assetName: AssetName.tape,
                                height: 24.w,
                                width: 24.w,
                              ),
                            ),
                            DiscoverSmallCard(
                              onTap: () {},
                              title: "Pottassium",
                              subtitle: "${_measures.k}",
                              gradientStartColor: const Color(0xffFFD541),
                              gradientEndColor: const Color(0xffF0B31A),
                            ),
                            DiscoverSmallCard(
                              onTap: () {},
                              title: "Moisture",
                              subtitle: "${_measures.moisture}",
                              gradientStartColor: const Color(0xff2193b0),
                              gradientEndColor: const Color(0xff6dd5ed),
                              icon: SvgAsset(
                                assetName: AssetName.tape,
                                height: 24.w,
                                width: 24.w,
                              ),
                            ),
                            DiscoverSmallCard(
                              onTap: () {},
                              title: "Temperature",
                              subtitle: "${_measures.temperature}",
                              gradientStartColor: const Color(0xffff512f),
                              gradientEndColor: const Color(0xffdd2476),
                              icon: SvgAsset(
                                assetName: AssetName.tape,
                                height: 24.w,
                                width: 24.w,
                              ),
                            ),
                            DiscoverSmallCard(
                              onTap: () {},
                              title: "pH",
                              subtitle: "${_measures.pH}",
                              gradientStartColor: const Color(0xff614385),
                              gradientEndColor: const Color(0xff516395),
                              icon: SvgAsset(
                                assetName: AssetName.tape,
                                height: 24.w,
                                width: 24.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _refresh();
                        },
                        child: const Text("Scan Values"))
                  ],
                )
              : const Center(child: CircularProgressIndicator())),
    );
  }
}

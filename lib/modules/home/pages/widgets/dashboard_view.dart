import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildHeader(),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(
                14,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF2A2D3F),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.08))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0,top: 5),
                    child: Text(
                      "Data Master",
                       style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                         fontSize: 18
                       ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => Divider(color: Colors.grey),
                    itemCount: 20,
                    itemBuilder: (_, index) {
                      return Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Color(0xFF2B344D),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        color: Colors.black.withOpacity(0.08))
                                  ]),
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Icon(
                                  Icons.filter_frames_sharp,
                                  color: Color(
                                    0xFF0F8FE8,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "Figma File",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                DateFormat("dd-MM-yyy").format(DateTime.now()),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "25 GB",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 150,
      width: double.maxFinite,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (_, __) => SizedBox(
          width: 10,
        ),
        itemBuilder: (_, index) {
          return Container(
            width: 200,
            padding: EdgeInsets.all(
              14,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF2A2D3F),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.08))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF2B344D),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 3,
                                color: Colors.black.withOpacity(0.08))
                          ]),
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Icon(
                          Icons.filter_frames_sharp,
                          color: Color(
                            0xFF0F8FE8,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.menu,
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Documents",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                LinearPercentIndicator(
                  width: 172,
                  lineHeight: 8.0,
                  percent: 0.5,
                  padding: EdgeInsets.zero,
                  barRadius: Radius.circular(10),
                  backgroundColor: Colors.white,
                  progressColor: index.isEven ? Colors.blue : Colors.orange,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "15023 Files",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "2.5 GB",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

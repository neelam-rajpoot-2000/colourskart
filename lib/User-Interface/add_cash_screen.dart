import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:virtual_casino/Utils/api_helper.dart';
import 'package:virtual_casino/Utils/apis.dart';
import 'package:virtual_casino/Widgets/customText.dart';

import '../Lucky7/Modal/deposit_type_model.dart';

class AddCashScreen extends StatefulWidget {
  bool? playBackgroundMusic=false;
   AddCashScreen({super.key,this.playBackgroundMusic });

  @override
  State<AddCashScreen> createState() => _AddCashScreenState();
}

class _AddCashScreenState extends State<AddCashScreen> {
  double height = 0;
  double width = 0;
  String catergoryNameValue = "All";
  bool bankButton = true;
  bool paytmButton = false;
  bool upiButton = false;
  List<DepositTypeModel> depositTypeList = [];
  bool loading = false;

  @override
  void initState() {
    getDepositTypeDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(body: OrientationBuilder(builder: (context, oreintation) {
      if (oreintation == Orientation.landscape) {
        return landScapeMode();
      } else {
        return portraitMode();
      }
    }));
  }

  Widget landScapeMode() {
    return SingleChildScrollView(
        child: Container(
      height: height,
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          headerAndAmountWidget(),
          SizedBox(
            height: 10,
          ),
          selectAmount(),
          SizedBox(
            height: 20,
          ),
          Container(
            width: width * 0.4,
            height: height * 0.1,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/User-interface/submit_button.png'))),
          ),
          SizedBox(
            height: 30,
          ),
          resultWidgetLandscape(),
        ],
      ),
    ));
  }

  Widget resultWidgetLandscape() {
    return Column(
      children: [
        Container(
          height: height * 0.1,
          width: width * 0.99,
          decoration: BoxDecoration(color: Color(0xaa292929)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.3,
                child: Text(
                  "Bank",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.2,
                child: Text(
                  "Image",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.2,
                child: Text(
                  "Amount",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.2,
                child: Text(
                  "Status",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        loading == true
            ? Column(
                children: const [
                  Text(
                    "Loading....",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              )
            : depositTypeList.isEmpty
                ? Text(
                    "No data Found !!",
                    style: TextStyle(color: Colors.white),
                  )
                : SizedBox(
                    height: height * 0.28,
                    width: width,
                    child: ListView.builder(
                        itemCount: depositTypeList.length,
                        itemBuilder: (context, index) {
                          var items = depositTypeList[index];
                          return Column(
                            children: [
                              SizedBox(
                                width: width * 0.99,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        items.bankName.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.14,
                                    ),
                                    Container(
                                      height: 80,
                                      width: 200,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  items.image.toString()))),
                                    ),
                                    SizedBox(
                                      width: width * 0,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        items.accountNumber.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.15,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        items.active.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.white60,
                              ),
                            ],
                          );
                        }),
                  ),
      ],
    );
  }

  Widget resultWidgetLandscapePortrait() {
    return Column(
      children: [
        Container(
          height: height * 0.05,
          width: width,
          decoration: BoxDecoration(color: Color(0xaa292929)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.3,
                child: Text(
                  "Date",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.2,
                child: Text(
                  "Image",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.2,
                child: Text(
                  "Amount",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.2,
                child: Text(
                  "Status",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 10,
        // ),
        // loading == true
        //     ? Column(
        //         children: const [
        //           Text(
        //             "Loading....",
        //             style: TextStyle(color: Colors.white),
        //           ),
        //           SizedBox(
        //             height: 5,
        //           ),
        //           CircularProgressIndicator(
        //             color: Colors.white,
        //           ),
        //         ],
        //       )
        //     : statementList.isEmpty
        //         ? Text(
        //             "No data Found !!",
        //             style: TextStyle(color: Colors.white),
        //           )
        //         : SizedBox(
        //             height: height * 0.3,
        //             width: width,
        //             child: ListView.builder(
        //                 itemCount: statementList.length,
        //                 itemBuilder: (context, index) {
        //                   var items = statementList[index];
        //                   return Column(
        //                     children: [
        //                       SizedBox(
        //                         width: width * 0.99,
        //                         child: Row(
        //                           children: [
        //                             Container(
        //                               margin: const EdgeInsets.symmetric(
        //                                   horizontal: 20),
        //                               child: Text(
        //                                 items.date.toString(),
        //                                 style: TextStyle(color: Colors.white),
        //                               ),
        //                             ),
        //                             SizedBox(
        //                               width: width * 0.18,
        //                             ),
        //                             Container(
        //                               margin: const EdgeInsets.symmetric(
        //                                   horizontal: 20),
        //                               child: Text(
        //                                 items.sno.toString(),
        //                                 style: TextStyle(color: Colors.white),
        //                               ),
        //                             ),
        //                             SizedBox(
        //                               width: width * 0.24,
        //                             ),
        //                             Container(
        //                               margin: const EdgeInsets.symmetric(
        //                                   horizontal: 20),
        //                               child: Text(
        //                                 items.credit.toString(),
        //                                 style: TextStyle(color: Colors.white),
        //                               ),
        //                             ),
        //                             SizedBox(
        //                               width: width * 0.09,
        //                             ),
        //                             Container(
        //                               margin: const EdgeInsets.symmetric(
        //                                   horizontal: 20),
        //                               child: Text(
        //                                 items.debit.toString(),
        //                                 style: TextStyle(color: Colors.white),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       Divider(
        //                         color: Colors.white60,
        //                       ),
        //                     ],
        //                   );
        //                 }),
        //           ),
      ],
    );
  }

  Widget headerAndAmountWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text(
              "Deposit",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                      widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                Navigator.pop(context);
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: width * 0.4,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Amount",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Container(
                alignment: Alignment.center,
                height: height * 0.1,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xaaA04B60),
                    ),
                    borderRadius: BorderRadius.circular(4)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, left: 8),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget headerAndAmountWidgetPortrait() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                      widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                Navigator.pop(context);
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
        SizedBox(),
        Padding(
          padding: EdgeInsets.only(top: height * 0.02),
          child: Text(
            "Deposit",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Enter Amount",
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 12,
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xaaA04B60),
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, left: 8),
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }

  Widget selectAmountPortrait() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            height: height * 0.04,
            width: width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Text(
              "100",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            height: height * 0.04,
            width: width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Text(
              "500",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            height: height * 0.04,
            width: width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Text(
              "1000",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            height: height * 0.04,
            width: width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Text(
              "10000",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectAmount() {
    return SizedBox(
      width: width * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            height: height * 0.08,
            width: width * 0.08,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Text(
              "100",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: height * 0.08,
            width: width * 0.08,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Text(
              "500",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: height * 0.08,
            width: width * 0.08,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Text(
              "1000",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: height * 0.08,
            width: width * 0.08,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            child: Text(
              "10000",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget portraitMode() {
    return SingleChildScrollView(
      child: Container(
        height: height,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            headerAndAmountWidgetPortrait(),
            selectAmountPortrait(),
            Container(
              width: width,
              height: height * 0.07,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/User-interface/submit_button.png'))),
            ),
            resultWidgetLandscapePortrait()
          ],
        ),
      ),
    );
  }

  Future getDepositTypeDetails() async {
    setState(() {
      loading = true;
    });
    var url = Apis.depositTypeApi;
    var data = {};
    var response = await GlobalFunction.apiPostRequestToken(url, data);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      var list = result['data'] as List;
      setState(() {
        depositTypeList.clear();
        depositTypeList =
            list.map((e) => DepositTypeModel.fromJson(e)).toList();
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }
}

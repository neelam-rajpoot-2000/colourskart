import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:virtual_casino/Utils/api_helper.dart';
import 'package:virtual_casino/Utils/apis.dart';
import 'package:virtual_casino/Utils/toast.dart';
import 'package:virtual_casino/data/model/statement_model.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  double height = 0;
  double width = 0;
  String startDate = "";
  String endDate = "";
  String numberOfRecords = "25";
  String types = "All";
  int typess = 1;
  int recordss = 25;
  bool loading = false;
  List<SatatementModel> statementList = [];
  List listName = [
    {"unit": "All", "action": true},
    {"unit": "Deposit/Withdrawal Report", "action": true},
    {"unit": "Game Report", "action": true},
  ];
  List listNames = [
    {"unit": "25", "action": true},
    {"unit": "50", "action": true},
    {"unit": "100", "action": true},
    {"unit": "200", "action": true},
    {"unit": "500", "action": true},
  ];
  String dropdownValue = "";
  String catergoryNameValue = "All";
  String entries = "25";

  @override
  void initState() {
    getStatementDetails();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(body: OrientationBuilder(builder: (context, oreintation) {
      if (oreintation == Orientation.landscape) {
        return landscapeWidget();
      } else {
        return potraitMode();
      }
    }));
  }

  Widget landscapeWidget() {
    return ListView(
      children: [
        Column(
          children: [
            accountWidgetLandScape(),
          ],
        )
      ],
    );
  }

  Widget accountWidgetLandScape() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "My Account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
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
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Dates Widget
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'From',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectDate();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.08,
                            width: width * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/User-interface/account_date_image.png"),
                                    fit: BoxFit.fitHeight)),
                            child: Text(
                              startDate == "" ? "Select" : startDate,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'To',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectEndDate();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.08,
                            width: width * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/User-interface/account_date_image.png"),
                                    fit: BoxFit.fitHeight)),
                            child: Text(
                              endDate == "" ? "Select" : endDate,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Type',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(4)),
                      width: width * 0.4,
                      height: height * 0.11,
                      child: DropdownButton(
                        dropdownColor: Colors.black,

                        value: catergoryNameValue,
                        style: TextStyle(color: Colors.white),
                        underline: const SizedBox(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        items: listName.map((items) {
                          return DropdownMenuItem(
                            value: items['unit'],
                            child: SizedBox(
                              height: height * 0.09,
                              width: width * 0.35,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  items['unit'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {
                          setState(() {
                            catergoryNameValue = newValue.toString();
                            types = catergoryNameValue;
                            if (types == "Deposit/Withdrawal Report") {
                              types = "3";
                              typess = int.parse(types);
                              getStatementDetails();
                              print("types-->$types");
                            }
                            if (types == "All") {
                              types = "1";
                              typess = int.parse(types);
                              getStatementDetails();

                              print("types-->$types");
                            }
                            if (types == "Game Report") {
                              types = "2";
                              typess = int.parse(types);
                              getStatementDetails();

                              print("types-->$types");
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (startDate != "" && endDate != "") {
                      getStatementDetails();
                    } else {
                      DialogUtils.showOneBtn(
                          context, "Please select From & to Date");
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    height: height * 0.1,
                    width: width * 0.36,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/User-interface/submit_button.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Show",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(4)),
                      width: width * 0.15,
                      height: height * 0.1,
                      child: DropdownButton(
                        underline: const SizedBox(),
                        dropdownColor: Colors.black,
                        value: entries,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        items: listNames.map((items) {
                          return DropdownMenuItem(
                            value: items['unit'],
                            child: SizedBox(
                              height: height * 0.09,
                              width: width * 0.11,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  items['unit'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {
                          setState(() {
                            entries = newValue.toString();
                            numberOfRecords = entries;
                            print("Records---->$numberOfRecords");
                            recordss = int.parse(numberOfRecords);
                            getStatementDetails();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Entries",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          resultWidgetLandscape(),
        ],
      ),
    );
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Date",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: width * 0.3,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Sr No.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: width * 0.2,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Credit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: width * 0.1,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Debit",
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
            : statementList.isEmpty
                ? Text(
                    "No data Found !!",
                    style: TextStyle(color: Colors.white),
                  )
                : SizedBox(
                    height: height * 0.3,
                    width: width,
                    child: ListView.builder(
                        itemCount: statementList.length,
                        itemBuilder: (context, index) {
                          var items = statementList[index];
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
                                        items.date.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.18,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        items.sno.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.24,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        items.credit.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.09,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        items.debit.toString(),
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

  Widget resultWidgetPortrait() {
    return Column(
      children: [
        Container(
          height: height * 0.1,
          width: width * 0.99,
          decoration: BoxDecoration(color: Color(0xaa292929)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Date",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: width * 0.28,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Sr No.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Credit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Debit",
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
            : statementList.isEmpty
                ? Text(
                    "No data Found !!",
                    style: TextStyle(color: Colors.white),
                  )
                : SizedBox(
                    height: height * 0.3,
                    width: width * 0.99,
                    child: ListView.builder(
                        itemCount: statementList.length,
                        itemBuilder: (context, index) {
                          var items = statementList[index];
                          return Column(
                            children: [
                              SizedBox(
                                width: width * 0.99,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        items.date.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        items.sno.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        items.credit.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        items.debit.toString(),
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

  Future selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      setState(() {
        startDate = formattedDate.toString();
        // dateInput.text =
        //     formattedDate; //set output date to TextField value.
      });
    } else {}
  }

  Future selectEndDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      setState(() {
        endDate = formattedDate.toString();
        // dateInput.text =
        //     formattedDate; //set output date to TextField value.
      });
    } else {}
  }

  Widget potraitMode() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "My Account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
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
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Dates Widget
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'From',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectDate();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.045,
                            width: width * 0.5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/User-interface/account_date_image.png"),
                                    fit: BoxFit.contain)),
                            child: Text(
                              startDate == "" ? "Select" : startDate,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'To',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectEndDate();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.045,
                            width: width * 0.45,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/User-interface/account_date_image.png"),
                                    fit: BoxFit.contain)),
                            child: Text(
                              endDate == "" ? "Select" : endDate,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  'Type',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(4)),
                width: width * 0.9,
                height: height * 0.05,
                child: DropdownButton(
                  dropdownColor: Colors.black,

                  value: catergoryNameValue,
                  style: TextStyle(color: Colors.white),
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  items: listName.map((items) {
                    return DropdownMenuItem(
                      value: items['unit'],
                      child: SizedBox(
                        height: height * 0.09,
                        width: width * 0.8,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            items['unit'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (newValue) {
                    setState(() {
                      catergoryNameValue = newValue.toString();
                      types = catergoryNameValue;
                      if (types == "Deposit/Withdrawal Report") {
                        types = "3";
                        typess = int.parse(types);
                        getStatementDetails();
                        print("types-->$types");
                      }
                      if (types == "All") {
                        types = "1";
                        typess = int.parse(types);
                        getStatementDetails();
                        print("types-->$types");
                      }
                      if (types == "Game Report") {
                        types = "2";
                        typess = int.parse(types);
                        getStatementDetails();
                        print("types-->$types");
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              if (startDate != "" && endDate != "") {
                getStatementDetails();
              } else {
                DialogUtils.showOneBtnPortrait(
                    context, "Please select proper date !!");
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: Container(
                height: height * 0.05,
                width: width * 0.9,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/User-interface/submit_button.png"),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Show",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(4)),
                width: width * 0.4,
                height: height * 0.06,
                child: DropdownButton(
                  underline: const SizedBox(),
                  dropdownColor: Colors.black,
                  value: entries,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  items: listNames.map((items) {
                    return DropdownMenuItem(
                      value: items['unit'],
                      child: SizedBox(
                        height: height * 0.06,
                        width: width * 0.3,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            items['unit'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (newValue) {
                    setState(() {
                      entries = newValue.toString();
                      numberOfRecords = entries;
                      print("Records---->$numberOfRecords");
                      recordss = int.parse(numberOfRecords);
                      getStatementDetails();
                    });
                  },
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Entries",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          resultWidgetPortrait(),
        ],
      ),
    );
  }

  //---------------API Call------------------//

  Future getStatementDetails() async {
    setState(() {
      loading = true;
    });
    var url = Apis.statementApi;
    var body = {
      "type": typess,
      "noOfRecords": recordss,
      "totalPages": 1,
      "index": 0,
      "fromDate":
          startDate.toString() == "" ? "2023-07-08" : startDate.toString(),
      "toDate": endDate.toString() == "" ? "2023-08-25" : endDate.toString(),
    };
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      var list = result['data']['dataList'] as List;
      setState(() {
        statementList.clear();
        var listdata = list.map((e) => SatatementModel.fromJson(e)).toList();
        statementList.addAll(listdata);
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Utils/api_helper.dart';
import '../Utils/apis.dart';
import '../data/model/match_id_model.dart';

class CurrentUserBet extends StatefulWidget {
  final String gameCode;
  final String matchId;
  const CurrentUserBet({
    super.key,
    required this.matchId,
    required this.gameCode,
  });

  @override
  State<CurrentUserBet> createState() => _CurrentUserBetState();
}

class _CurrentUserBetState extends State<CurrentUserBet> {
  double height = 0;
  double width = 0;
  String entries = "25";
  bool loading = false;
  bool allButton = true;
  bool backButton = false;
  bool layButton = false;

  List<MatchIdModel> matchIdList = [];

  List listNames = [
    {"unit": "25", "action": true},
    {"unit": "50", "action": true},
    {"unit": "100", "action": true},
    {"unit": "200", "action": true},
    {"unit": "500", "action": true},
  ];
  @override
  void initState() {
    getMatchIdDetails();
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
        return portraitMode();
      }
    }));
  }

  Widget landscapeWidget() {
    return SingleChildScrollView(
        child: Container(
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
                "Current Bets",
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
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            width: width,
            height: 40,
            color: Color(0xaa292929),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("Market Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("Nation",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("Rate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("Price Value",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("Amount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text("Pnl",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
                SizedBox(
                  width: 50,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text("Place Date",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
          loading == true
              ? Column(
                  children: const [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Loading....",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              : matchIdList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "No data found!!",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  : SizedBox(
                      height: height * 0.68,
                      width: width,
                      child: ListView.builder(
                          itemCount: matchIdList.length,
                          itemBuilder: (context, index) {
                            var items = matchIdList[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: width * 0.15,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.marketName.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      width: width * 0.1,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.nation.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Container(
                                      width: width * 0.08,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.rate.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      width: width * 0.1,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.priveValue.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      width: width * 0.04,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.amount.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: width * 0.09,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: Text(items.pnl.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: width * 0.12,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: Text(items.betTime.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Color(0xaa2E2E2E),
                                  thickness: 1,
                                ),
                              ],
                            );
                          }),
                    ),
        ],
      ),
    ));
  }

  Widget portraitMode() {
    return SingleChildScrollView(
        child: Container(
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
                "Current Bets",
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
            height: 20,
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            width: width,
            height: 40,
            color: Color(0xaa292929),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width / 7,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("Sports",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
                ),
                Container(
                  width: width / 9,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("Event Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
                ),
                Container(
                  width: width / 5,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("Market Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
                ),
                Container(
                  width: width / 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("Nation",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
                ),
                Container(
                  width: width / 10,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("User Rate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
                ),
                Container(
                  width: width / 9,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text("Amount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
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
              : matchIdList.isEmpty
                  ? Text(
                      "No data Found !!",
                      style: TextStyle(color: Colors.white),
                    )
                  : SizedBox(
                      height: height * 0.6,
                      width: width,
                      child: ListView.builder(
                          itemCount: matchIdList.length,
                          itemBuilder: (context, index) {
                            var items = matchIdList[index];
                            return Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width / 7,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Text(items.nation.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          )),
                                    ),
                                    Container(
                                      width: width / 9,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Text(items.priveValue.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          )),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: width / 5,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Text(items.marketName.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          )),
                                    ),
                                    Container(
                                      width: width / 6,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Text(items.nation.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          )),
                                    ),
                                    Container(
                                      width: width / 10,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Text(items.rate.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          )),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: width / 10,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Text(items.amount.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          )),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Color(0xaa2E2E2E),
                                  thickness: 1,
                                ),
                              ],
                            );
                          }),
                    ),
        ],
      ),
    ));
  }

  //-------------API Call----------------//
  Future getMatchIdDetails() async {
    print("game code ----->${widget.gameCode}");
    setState(() {
      loading = true;
    });
    var url = Apis.matchId;
    var body = {"matchId": widget.matchId};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      setState(() {
        var list = result['data'][widget.gameCode] as List;
        matchIdList.clear();
        var listdata = list.map((e) => MatchIdModel.fromJson(e)).toList();
        matchIdList.addAll(listdata);
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

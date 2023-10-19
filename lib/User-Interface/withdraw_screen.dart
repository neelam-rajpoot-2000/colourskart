import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widgets/customText.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  List listName = [
    {"unit": "All", "action": true},
    {"unit": "Deposit/Withdrawal Report", "action": true},
    {"unit": "Game Report", "action": true},
  ];
  double height = 0;
  double width = 0;
  String catergoryNameValue = "All";
  bool bankButton = true;
  bool paytmButton = false;
  bool upiButton = false;

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

 Widget headerAndAmountWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text(
              "Withdraw",
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
 Widget headerAndAmountWidgetPortait() {
    return Column(
      children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
        Text(
          "Withdraw",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      
      
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             CustomText(text:  "Enter Amount" ,
              fontWeight: FontWeight.w500,
                color: Colors.white, fontSize: 12,
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
              style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
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


 
  Widget selectType() {
    return Container(
      width: width * 0.4,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Type",
            style: TextStyle(color: Colors.white, fontSize: 12),
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
                });
              },
            ),
          ),
        ],
      ),
    );
  }
Widget selectTypePortrait() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text:  "Type" ,
                fontWeight: FontWeight.w500,
                  color: Colors.white, fontSize: 14,
                ),
          Container(
              margin: EdgeInsets.only(top: 5),
    
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(4)),
            width: width ,
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
                    width: width*0.85 ,
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
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  
  Widget selectMethodWidget() {
    return SizedBox(
      width: width * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    bankButton = true;
                    paytmButton = false;
                    upiButton = false;
                  });
                },
                child: Text(
                  "Bank",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              bankButton == true
                  ? Container(
                      height: 3,
                      width: width * 0.1,
                      decoration: BoxDecoration(color: Color(0xaaFAD461)),
                    )
                  : SizedBox(),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    bankButton = false;
                    paytmButton = true;
                    upiButton = false;
                  });
                },
                child: Text(
                  "paytm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              paytmButton == true
                  ? Container(
                      height: 3,
                      width: width * 0.1,
                      decoration: BoxDecoration(color: Color(0xaaFAD461)),
                    )
                  : SizedBox(),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    bankButton = false;
                    paytmButton = false;
                    upiButton = true;
                  });
                },
                child: Text(
                  "UPI",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              upiButton == true
                  ? Container(
                      height: 3,
                      width: width * 0.1,
                      decoration: BoxDecoration(color: Color(0xaaFAD461)),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
 Widget selectMethodWidgetPortrait() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    bankButton = true;
                    paytmButton = false;
                    upiButton = false;
                  });
                },
                child: Text(
                  "Bank",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              bankButton == true
                  ? Container(
                      height: 3,
                      width: width * 0.1,
                      decoration: BoxDecoration(color: Color(0xaaFAD461)),
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(width: width*0.08,),
          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    bankButton = false;
                    paytmButton = true;
                    upiButton = false;
                  });
                },
                child: Text(
                  "paytm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              paytmButton == true
                  ? Container(
                      height: 3,
                      width: width * 0.1,
                      decoration: BoxDecoration(color: Color(0xaaFAD461)),
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(width: width*0.08,),

          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    bankButton = false;
                    paytmButton = false;
                    upiButton = true;
                  });
                },
                child: Text(
                  "UPI",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              upiButton == true
                  ? Container(
                      height: 3,
                      width: width * 0.1,
                      decoration: BoxDecoration(color: Color(0xaaFAD461)),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

 
  Widget bankWidget() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.4,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Account Number",
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
              ),
              Container(
                width: width * 0.4,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Account Name",
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
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.4,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Bank Name",
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
              ),
              Container(
                width: width * 0.4,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter IFSC Code",
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
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.4,
                height: height * 0.1,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/User-interface/submit_button.png'))),
              ),
              Container(
                width: width * 0.4,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Type",
                      style: TextStyle(color: Colors.white, fontSize: 12),
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
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
Widget bankWidgetPortrait() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
             
               CustomText(text:    "Enter Account Number",
                fontWeight: FontWeight.w500,
                  color: Colors.white, fontSize: 12,
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
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: height*0.015,),
               CustomText(text:    "Enter Account Name",
                fontWeight: FontWeight.w500,
                  color: Colors.white, fontSize: 12,
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
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: height*0.015,),
          
            CustomText(text:    "Enter Bank Name",
                fontWeight: FontWeight.w500,
                  color: Colors.white, fontSize: 12,
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
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: height*0.015,),

          Text(
            "Enter IFSC Code",
            style: TextStyle(color: Colors.white, fontSize: 12),
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
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: height*0.015,),

                Text(
                  "Account Type",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                   Container(
              margin: EdgeInsets.only(top: 5),
    
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(4)),
            width: width ,
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
                  width: width*0.85 ,
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
                });
              },
            ),
          ),
             
                     SizedBox(height: height*0.015,),

          Container(
            width: width ,
            height: height * 0.06,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/User-interface/submit_button.png'))),
          ),
       
        ],
      ),
    );
  }

  
  Widget paytmWidget() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.4,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Mobile Number",
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
              ),
              Container(
                width: width * 0.4,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Account Name",
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
              ),
            ],
          ),
        ),
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
          height: 20,
        ),
      ],
    );
  }
  Widget paytmWidgetPortrait() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            CustomText(text: "Enter Mobile Number",
                fontWeight: FontWeight.w500,
                  color: Colors.white, fontSize: 12,
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
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
                        SizedBox(height: height*0.015,),
                  CustomText(text:      "Enter Account Name",
                fontWeight: FontWeight.w500,
                  color: Colors.white, fontSize: 12,
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
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
       
          Container(
            width: width,
            height: height * 0.08,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/User-interface/submit_button.png'))),
          ),
        
        ],
      ),
    );
  }

  
  Widget upiWidget() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.4,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Upi Id",
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
              ),
              Container(
                width: width * 0.4,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Account Name",
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
              ),
            ],
          ),
        ),
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
          height: 20,
        ),
      ],
    );
  }
 Widget upiWidgetPortrait() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter Upi Id",
            style: TextStyle(color: Colors.white, fontSize: 12),
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
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                          SizedBox(height: height*0.015,),
          Text(
            "Enter Account Name",
            style: TextStyle(color: Colors.white, fontSize: 12),
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
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                          SizedBox(height: height*0.015,),
          Container(
            width: width ,
            height: height * 0.06,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/User-interface/submit_button.png'))),
          ),
         
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
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.12,
                child: Text(
                  "Account Number",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.12,
                child: Text(
                  "Account Name",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.12,
                child: Text(
                  "Amount",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.14,
                child: Text(
                  "Account Type/Currency",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.14,
                child: Text(
                  "Bank Name/Address",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.12,
                child: Text(
                  "IFSC Code",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.12,
                child: Text(
                  "Remark",
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
 Widget resultWidgetLandscapePortrait() {
    return Column(
      children: [
        Container(
          height: height * 0.1,
          width: width ,
          decoration: BoxDecoration(color: Color(0xaa292929)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.1,
                child: Text(
                  "Account Number",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.1,
                child: Text(
                  "Account Name",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.1,
                child: Text(
                  "Amount",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.1,
                child: Text(
                  "Account Type/Currency",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.1,
                child: Text(
                  "Bank Name/Address",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.1,
                child: Text(
                  "IFSC Code",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: width * 0.1,
                child: Text(
                  "Remark",
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

 
  Widget portraitMode() {
    return SingleChildScrollView(
      child:  Container(

        decoration: BoxDecoration(color: Colors.black),
        child:Column(
          children: [
            headerAndAmountWidgetPortait(),
            selectAmountPortrait(),
            selectTypePortrait(),
            selectMethodWidgetPortrait(),
             bankButton == true
                ? bankWidgetPortrait()
                : paytmButton == true
                    ? paytmWidgetPortrait()
                    : upiButton == true
                        ? upiWidgetPortrait()
                        : SizedBox(),
                                  resultWidgetLandscapePortrait(),
          ],
        )
        ,)
    );
  }

  Widget landScapeMode() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            headerAndAmountWidget(),
            SizedBox(
              height: 10,
            ),
            selectAmount(),
            SizedBox(
              height: 10,
            ),
            selectType(),
            SizedBox(
              height: 20,
            ),
            selectMethodWidget(),
            SizedBox(
              height: 20,
            ),
            bankButton == true
                ? bankWidget()
                : paytmButton == true
                    ? paytmWidget()
                    : upiButton == true
                        ? upiWidget()
                        : SizedBox(),
            // paytmWidget(),
            // bankWidget(),
            resultWidgetLandscape(),
          ],
        ),
      ),
    );
  }

 
}

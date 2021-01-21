import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class TrackOrder extends StatefulWidget {
  TrackOrder({Key key}) : super(key: key);
  static const routeName = '/trackOrder';

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  bool _showDetails = false;
  String orderId = "";
  String orderDetails = "";
  var url = "https://unistam.co.in/yoyopizzaapp/track_id.php",data="";

  final Color customColor = Hexcolor("#00b34d");

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        title: Text("YoYo Pizza"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    child: CupertinoTextField(
                      decoration: BoxDecoration(
                          border: Border.all(color: customColor),
                          borderRadius: BorderRadius.circular(8)),
                      controller: controller,
                      placeholder: "Enter Order ID",
                    ),
                  ),
                  SizedBox(height: 150),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        var res = await http.post(url,
                            body: {
                              "ord_id": controller.text
                            }
                        );
                        data = res.body;
                        setState(() {
                          orderId = controller.text;
                          // FETCH ORDER DETAILS AND STORE IT IN THE BELOW VARIABLE
                          orderDetails=data;
                          //mesResp(orderId);
                          _showDetails = true;
                        });
                        print(controller.text);
                      })
                ],
              ),
            ),
            _showDetails
                ? Container(
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: customColor.withOpacity(0.2),
                          offset: Offset(10, 10),
                          blurRadius: 20,
                        ),
                        BoxShadow(
                          color: customColor.withOpacity(0.5),
                          offset: Offset(-10, -10),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          orderId,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                        Html(
                          data: orderDetails,
                          style: {
                            "body": Style(
                              fontSize: FontSize(18.0),
                            ),
                          },),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

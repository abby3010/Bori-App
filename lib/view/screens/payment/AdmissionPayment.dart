// ignore_for_file: file_names, annotate_overrides, prefer_const_constructors, override_on_non_overriding_member, avoid_print, unused_field, avoid_unnecessary_containers, prefer_typing_uninitialized_variables

import 'package:bori_app/themes/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class AdmissionPayment extends StatefulWidget {
  final fees;
  final name;
  final email;
  final phone;
  final address;
  final age;
  final course;

  const AdmissionPayment(
      {Key? key,
      this.fees,
      this.address,
      this.age,
      this.course,
      this.email,
      this.name,
      this.phone})
      : super(key: key);

  @override
  _AdmissionPaymentState createState() => _AdmissionPaymentState();
}

bool isLoading = true; //this can be declared outside the class

class _AdmissionPaymentState extends State<AdmissionPayment> {
  double progress = 0;
  @override
  String? selectedUrl;
  String? url;
  String? paymentRequestID;
  bool successStatus = false;

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  void initState() {
    createRequest();

    print(selectedUrl);

    super.initState();
    //creating the HTTP request
  }

  Future createRequest() async {
    Map<String, String> body = {
      "amount": widget.fees, //amount to be paid
      "purpose": "Admission",
      "buyer_name": widget.name ?? 'dummy',
      "email": widget.email ?? 'dummy@gmail.com',
      "phone": widget.phone ?? '8665643435',
      "allow_repeated_payments": "true",
      "send_email": "true",
      "send_sms": "true",
      // "redirect_url": url ?? 'https://www.google.com/',
      //Where to redirect after a successful payment.
      // "webhook": "https://www.google.com/",
    };
    //First we have to create a Payment_Request.
    //then we'll take the response of our request.
    var resp = await http.post(
        Uri.parse("https://test.instamojo.com/api/1.1/payment-requests/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": "test_471c4569e7c0bbec66bacecaea1",
          "X-Auth-Token": "test_dbd4f9391fd3909c0736a61506d"
        },
        body: body);
    if (json.decode(resp.body)['success'] == true) {
      //If request is successful take the longurl.
      print("===========================================");
      print(json.decode(resp.body));
      setState(() {
        isLoading = false; //setting state to false after data loaded
        paymentRequestID = json.decode(resp.body)["payment_request"]['id'];
        selectedUrl =
            json.decode(resp.body)["payment_request"]['longurl'].toString();
        print("SElected URL");
        print(selectedUrl);
      });
      // print(json.decode(resp.body)['message'].toString());
      //If something is wrong with the data we provided to
      //create the Payment_Request. For Example, the email is in incorrect format, the payment_Request creation will fail.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.AppBarTheme,
        elevation: 0,
        title: Text("Pay"),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? //check loadind status
              CircularProgressIndicator()
              : InAppWebView(
                  key: webViewKey,
                  initialOptions: options,
                  initialUrlRequest: URLRequest(
                    url: Uri.tryParse(selectedUrl!),
                  ),

                  // javascriptMode: JavascriptMode.unrestricted,

                  onWebViewCreated: (InAppWebViewController webViewController) {
                    // _controller.complete(webViewController);
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  onUpdateVisitedHistory: (_, Uri? uri, __) {
                    String url = uri.toString();
                    print("ANder wakai" + url);
                    print(uri);
                    // uri containts newly loaded url
                    if (mounted) {
                      if (url.contains('https://test.instamojo.com/order/status')) {
                        //Take the payment_id parameter of the url.
                        String? paymentRequestId = uri?.pathSegments[2];
                        print("value is: " + paymentRequestId.toString());
                        //calling this method to check payment status
                        _checkPaymentStatus(paymentRequestID!);
                      }
                    }
                  },
                ),
        ),
      ),
    );
  }

  _checkPaymentStatus(String id) async {
    var response = await http.get(
        Uri.parse("https://test.instamojo.com/api/1.1/payment-requests/$id/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-Api-Key": "test_471c4569e7c0bbec66bacecaea1",
          "X-Auth-Token": "test_dbd4f9391fd3909c0736a61506d"
        });
    var realResponse = json.decode(response.body);
    print("********************%%%%%%%%%%%%%%");
    print("response is: " + realResponse.toString());
    if (realResponse['success'] == true) {
      print('sucesssssssssssful');
      if (realResponse["payment_request"]['payments'][0]['status'] == "Credit") {
        FirebaseFirestore.instance
            .collection("Admission")
            .add({
              "Name": widget.name,
              "Phone": widget.phone,
              "email": widget.email,
              "payment": realResponse,
              "age": widget.age,
              "Address": widget.address,
              "Course": widget.course,
              "fees": widget.fees,
            })
            .then((value) => print("Addmission Document Added"))
            .catchError((error) => print("Failed to add user: $error"));

//payment is successful.
      } else {
        print('failed');
//payment failed or pending.
      }
    } else {
      print("PAYMENT STATUS FAILED");
    }
  }
}

//import 'package:flutter/material.dart';
//import 'package:covid_health_app/constants/app_colors.dart';
//import 'package:covid_health_app/firestore/db.dart';
//import 'package:covid_health_app/modals/Appointment.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
//import 'package:toast/toast.dart';//

//class AppointmentPayment extends StatefulWidget {
//  final String pN;
//  final String dN;
//  final String date;
//  final int amount;
//  AppointmentPayment(this.pN, this.dN, this.amount, this.date);
//  _AppointmentPaymentState createState() => _AppointmentPaymentState();
//}//

//class _AppointmentPaymentState extends State<AppointmentPayment> {
//  Razorpay razorpay;
//  TextEditingController textEditingController = new TextEditingController();//

//  @override
//  void initState() {
//    super.initState();//

//    razorpay = new Razorpay();//

//    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
//    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
//    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
//  }//

//  @override
//  void dispose() {
//    super.dispose();
//    razorpay.clear();
//  }//

//  void openCheckout() {
//    var options = {
//      "key": "rzp_live_dqNRpgOISWkB7L",
//      "amount": widget.amount * 100,
//      "currency": "INR",
//      "name": "Apointment Payment",
//      "description": "Payment for Doctor Appointment",
//      "prefill": {
//        'email': widget.pN,
//      },
//      "external": {
//        "wallets": ["paytm"]
//      }
//    };//

//    try {
//      razorpay.open(options);
//    } catch (e) {
//      print(e.toString());
//    }
//  }//

//  void handlerPaymentSuccess(PaymentSuccessResponse response) {
//    print("Pament success");
//    Toast.show("Pament success", context);
//    Appointment a = new Appointment();
//    a.aDateS = widget.date;
//    a.paymentID = response.paymentId;
//    a.paymentAmount = widget.amount;//

//    DB().confirmPayment(widget.dN, widget.pN, a);
//    DB().createTransaction(widget.dN, widget.pN, a);
//    String input = "Your appointment on the date " +
//        a.aDateS.substring(0, 10) +
//        " is fixed";
//    DB().sendNotification(widget.dN, input, widget.pN);
//    DB().sendNotificationPatient(widget.pN, input, widget.dN);
//  }//

//  void handlerErrorFailure(PaymentFailureResponse response) {
//    print("Pament error");
//    Toast.show("Pament error", context);
//  }//

//  void handlerExternalWallet(ExternalWalletResponse response) {
//    print("External Wallet");
//    Toast.show("External Wallet", context);
//  }//

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Padding(
//        padding: const EdgeInsets.all(30.0),
//        child: Column(
//          children: [
//            Text(
//              "Amount to Pay : " + widget.amount.toString(),
//              style: TextStyle(
//                  color: primaryColor,
//                  fontSize: 30,
//                  fontWeight: FontWeight.bold),
//            ),
//            SizedBox(
//              height: 12,
//            ),
//            RaisedButton(
//              color: primaryColor,
//              child: Text(
//                "Pay Now",
//                style: TextStyle(color: Colors.white),
//              ),
//              onPressed: () {
//                openCheckout();
//              },
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}

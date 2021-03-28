//mport 'package:flutter/material.dart';
//mport 'package:razorpay_flutter/razorpay_flutter.dart';
//mport 'package:toast/toast.dart';
//
//
//lass AppointmentPayment extends StatefulWidget {
// @override
// _AppointmentPaymentState createState() => _AppointmentPaymentState();
//
//
//lass _AppointmentPaymentState extends State<AppointmentPayment> {
// Razorpay razorpay;
// TextEditingController textEditingController = new TextEditingController();
//
// @override
// void initState() {
//   super.initState();
//
//   razorpay = new Razorpay();
//
//   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
//    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
//    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    razorpay.clear();
//  }
//
//  void openCheckout() {
//    var options = {
//      "key": "rzp_test_uvasfHBCvNm0QR",
//      "amount": num.parse(textEditingController.text) * 100,
//      "name": "Apointment Payment",
//      "description": "Payment for Doctor Appointment",
//      "prefill": {
//        "contact": "2323232323",
//        "email": "menonhealthtech@gmail.com"
//      },
//      "external": {
//       "wallets": ["paytm"]
//     }
//   };
//
//   try {
//     razorpay.open(options);
//   } catch (e) {
//     print(e.toString());
//   }
// }
//
// void handlerPaymentSuccess() {
//   print("Pament success");
//   Toast.show("Pament success", context);
// }
//
// void handlerErrorFailure() {
//   print("Pament error");
//   Toast.show("Pament error", context);
// }
//
// void handlerExternalWallet() {
//   print("External Wallet");
//   Toast.show("External Wallet", context);
// }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("Payment"),
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(30.0),
//       child: Column(
//         children: [
//            TextField(
//              controller: textEditingController,
//              decoration: InputDecoration(hintText: "amount to pay"),
//            ),
//            SizedBox(
//              height: 12,
//            ),
//            RaisedButton(
//              color: Colors.blue,
//              child: Text(
//                "Donate Now",
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

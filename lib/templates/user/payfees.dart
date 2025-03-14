import 'dart:convert';

import 'package:fitnessappnew/templates/user/user_home.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Razorpay ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  TextEditingController _amountController = TextEditingController();
  String amount_ = '';

  @override
  void initState() {
    super.initState();
    h();

    // Initialize Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> h() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      amount_ = sh.getString("amd").toString().split(".")[0];
    });
  }

  @override
  void dispose() {
    // Dispose Razorpay when the widget is disposed
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success: ${response.paymentId}");

    // Handle success scenario here
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.message}");
    // Handle error scenario here
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
    // Handle external wallet scenario here
  }

  void _openCheckout(String amt) {
    try {
      int amount = int.parse(amt) * 100; // Amount in paise
      var options = {
        'key': 'rzp_test_edrzdb8Gbx5U5M',
        'amount': amount,
        'name': 'Flutter Razorpay Demo',
        'description': 'Test Payment',
        'prefill': {
          'contact': '9745117935',
          'email': 'akhilaregional@gmail.com'
        },
        'external': {
          'wallets': ['paytm'] // Add the wallets you want to support
        }
      };

      _razorpay.open(options);
      print(_razorpay.toString());
      print("okkkkkkkk");
    } catch (e) {
      print("Error");
      print("Error in opening Razorpay: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Razorpay '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //    'amount'+ amount_
            // ),
            // TextField(
            //   controller: amount_,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(labelText: 'Enter Amount'),
            // ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    _openCheckout(amount_);
                    final sh = await SharedPreferences.getInstance();
                    String amount = amount_.toString();
                    // String Passwd=passwordController.text.toString();
                    String url = sh.getString("url").toString();
                    String bid = sh.getString("sid").toString();
                    String lid = sh.getString("lid").toString();
                    print("okkkkkkkkkkkkkkkkk");
                    var data =
                        await http.post(Uri.parse(url + "/payment"), body: {
                      'sid': bid,
                      'lid': lid,
                      // 'amount': amount,
                    });
                    var jasondata = json.decode(data.body);
                    String status = jasondata['status'].toString();
                    if (status == "ok") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      print("error");
                    }
                  },
                  child: Text('Pay Now  :' + 200.toString()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

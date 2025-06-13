import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RasorScreen extends StatefulWidget {
  const RasorScreen({super.key});

  @override
  State<RasorScreen> createState() => _RasorScreenState();
}

class _RasorScreenState extends State<RasorScreen> {
  late Razorpay _razorpay;
  TextEditingController amountController = TextEditingController();
  void Opencheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_XkieUIQwc3ijDh',
      'amount': amount,
      'name': 'SBI Corp',
      'prefill': {'contact': '7907472174', 'email': 'alanvz757@gmail.com'},
      'external': {
        'wallets': ['paytm'],
      },
    };
    // Implement the logic to open the Razorpay checkout
    try {
      _razorpay.open(options);
      // Assuming _rasorpay.open() is the method to open the checkout
      // await _rasorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay checkout: $e');
      // Handle any errors that occur during the checkout process
      print('Error: $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success logic here
    print('Payment successful');
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error logic here
    print('Payment failed');
  }

  void handleExternalWalletPayment(PaymentSuccessResponse response) {
    // Handle external wallet payment success logic here
    print('External wallet payment successful');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletPayment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100),
            Image.network(
              'https://imgs.search.brave.com/m8kpuitH21C-P3OvKk7gVVgZrfEFUASTM8V4V9y1We4/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/d2lzZG9tb2ZwbGFu/ZXRzLmNvbS93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyNC8xMS9m/cmVlLXJhem9ycGF5/LWljb24tZG93bmxv/YWQtaW4tc3ZnLXBu/Zy1naWYtZmlsZS1m/b3JtYXRzLWNvbXBh/bnktYnJhbmQtbG9n/by1zb2NpYWwtbWVk/aWEtMS1wYWNrLWxv/Z29zLWljb25zLTEw/NDM5MzA5LnBuZw',
              width: 300,
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to Razorpay payment integration',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.black,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorStyle: TextStyle(color: Colors.red),
                ),
                controller: amountController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount to be paid';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (amountController.text.toString().isNotEmpty) {
                  setState(() {
                    int amount = int.parse(amountController.text);
                    Opencheckout(amount);
                  });
                }
                ;
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Make Payment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

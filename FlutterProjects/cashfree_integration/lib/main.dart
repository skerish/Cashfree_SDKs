import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';

import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:pointycastle/asymmetric/api.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _selectedApp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cashfree SDK Sample'),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                child: const Text('WEB CHECKOUT'),
                onPressed: () => makePayment(),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('SEAMLESS CARD'),
                onPressed: () => seamlessCardPayment(),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('SEAMLESS NETBANKING'),
                onPressed: () => seamlessNetbankingPayment(),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('SEAMLESS WALLET'),
                onPressed: () => seamlessWalletPayment(),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('SEAMLESS UPI COLLECT'),
                onPressed: () => seamlessUPIPayment(),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('SEAMLESS PAYPAL'),
                onPressed: () => seamlessPayPalPayment(),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('UPI INTENT'),
                onPressed: () => makeUpiPayment(),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('GET INSTALLED UPI APPS'),
                onPressed: () => getUPIApps(),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('SEAMLESS UPI INTENT'),
                onPressed: () => seamlessUPIIntent(),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('SIGNATURE'),
                onPressed: () => generateSignatureFromPublicKey(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getUPIApps() {
    CashfreePGSDK.getUPIApps().then((value) => {
          if (value != null && value.isNotEmpty) {_selectedApp = value[0]}
        });
  }

  static void generateSignatureFromPublicKey() async {
    int currentTimeInUnix =
        DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
    String clientIdWithUnixTime =
        "CF146982CBBQNHD6LA05QI8T403G." + currentTimeInUnix.toString();

    print("clientIdwithUnixTime : " + clientIdWithUnixTime.toString());

    final publickey = await parseKeyFromFile<RSAPublicKey>(
        'C:/Users/Kerish K/Desktop/PUBLIC_KEY_TEST.pem');

    final encrypter =
        Encrypter(RSA(publicKey: publickey, encoding: RSAEncoding.OAEP));
    final encrypted = encrypter.encrypt(clientIdWithUnixTime);

    print("signature:\n" + encrypted.base64);
  }

  // WEB Intent
  makePayment() {
    //Replace with actual values
    String orderId = "test_order_01_11_01";
    String stage = "TEST";
    String orderAmount = "100";
    String tokenData =
        "VW9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.tv9JSO2YTZwMjYmJGM2MjNiojI0xWYz9lIsUTM5YzN4kjN2EjOiAHelJCLiIlTJJiOik3YuVmcyV3QyVGZy9mIsADMxojI05Wdv1WQyVGZy9mIsISMw8VMx8VMw8lclRmcv9FdzVGdiojIklkclRmcvJye.HJsGkbauv6Fxum_INlwZOuC2xYUXUNqKQ8cHfdBCrGW5yFcHYRcT9dncWp4hDgO35p";
    String customerName = "TEST";
    String orderNote = "TEST NOTE";
    String orderCurrency = 'INR';
    String appId = "1469829d60873d925cec9f77a1289641";
    String customerPhone = "7772876910";
    String customerEmail = "dc@gmail.com";
    String notifyUrl =
        "https://ecom.mkart.dev/api/v1/payments/notify/1661493683M710";
    String returnUrl =
        "https://www.google.com?order_id={order_id}&order_token={order_token}";

    // Map<String, dynamic> inputParams = {
    //   "orderId": orderId,
    //   "orderAmount": orderAmount,
    //   "customerName": customerName,
    //   "orderNote": orderNote,
    //   "orderCurrency": orderCurrency,
    //   "appId": appId,
    //   "customerPhone": customerPhone,
    //   "customerEmail": customerEmail,
    //   "stage": stage,
    //   "tokenData": tokenData,
    //   "notifyUrl": notifyUrl,
    //   "paymentModes": "paylater,ccemi,dcemi",
    //   // "paymentSplits": "WwogewogICAidmVuZG9ySWQiIDogIk5FVzEiLAogICAicGVyY2VudGFnZSIgOiAxMAogfSwKIHsKICAgInZlbmRvcklkIiA6ICJORVcyIiwKICAgInBlcmNlbnRhZ2UiIDogOTAKIH0KXQ==",
    //   "returnUrl": returnUrl
    // };

    Map<String, dynamic> inputParams = {
      "color1": "#ffffff",
      "color2": "#11385b",
      "stage": "TEST",
      "appId": "1469829d60873d925cec9f77a1289641",
      "orderId": "VDEAL166840579928131-3",
      "orderCurrency": "INR",
      "orderAmount": "1000.00",
      "orderNote": "service_type!voucher",
      "customerName": "Abhijeet",
      "customerPhone": "8800647981",
      "customerEmail": "Abhijeet@gmail.com",
      "notifyUrl": "https://ixifly.in/git/payment_api/payment/webhook/handle_payments/cashfree",
      "paymentModes": "paylater",
      "paymentCode": null,
      "paymentOption": null,
      "tokenData": "jQ9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.GPQfiYGNxIDZ4cjZkFzNzYjI6ICdsF2cfJCLwYTM5kTOwcjNxojIwhXZiwiIS5USiojI5NmblJnc1NkclRmcvJCLwADMxojI05Wdv1WQyVGZy9mIsIyMtEzMxgjM5kzN1ADN4YjNxwUQFRkViojIklkclRmcvJye.RxCUleZcndGJa7cg1joe8HI5Ka64ehMq3xcuiit5ysMxNXlPnRXQ65kQSPy5kx46or",
      "salt": null
    };

    CashfreePGSDK.doPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
            }));
  }

  // SEAMLESS - CARD
  Future<void> seamlessCardPayment() async {
    String orderId = "test_order_31_10_02";
    String stage = "TEST";
    String orderAmount = "100";
    String tokenData =
        "939JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.bG9JiYxMjMmZWYlVjZ1MjNiojI0xWYz9lIsMDN1YDO3kjN2EjOiAHelJCLiIlTJJiOik3YuVmcyV3QyVGZy9mIsADMxojI05Wdv1WQyVGZy9mIsIiMw8FMx8VMz8lclRmcv9FdzVGdiojIklkclRmcvJye.8A04I7TEQjQU6iyGUiD5Nt_ldWdxp8kEyu1CnwCA0-UDWq185cspyYoLNzjCVy_739";
    String customerName = "Jerry";
    String orderNote = "Test Note";
    String orderCurrency = "INR";
    String appId = "1469829d60873d925cec9f77a1289641";
    String customerPhone = "1234567890";
    String customerEmail = "kerish.kumar@cashfree.com";
    String notifyUrl =
        "https://webhook.site/f3ce1ecc-fcad-4f7d-be99-d757aed07156";
    String paymentOption = "card";
    String cardNumber = "4706131211212123";
    String expMonth = "07";
    String expYear = "2023";
    String cardHolder = "Test";
    String cvv = "123";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,
      // EXTRA THINGS THAT NEEDS TO BE ADDED
      "paymentOption": paymentOption,
      "card_number": cardNumber,
      "card_expiryMonth": expMonth,
      "card_expiryYear": expYear,
      "card_holder": cardHolder,
      "card_cvv": cvv
    };

    CashfreePGSDK.doPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
              //Do something with the result
            }));
  }

  // SEAMLESS - NETBANKING
  Future<void> seamlessNetbankingPayment() async {
    String orderId = "test_order_26_09_03";
    String stage = "TEST";
    String orderAmount = "100";
    String tokenData =
        "p89JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.zD9JCM5QmMjNWMjdTMzMjNiojI0xWYz9lIsAjM0kzN3YjN2EjOiAHelJCLiIlTJJiOik3YuVmcyV3QyVGZy9mIsADMxojI05Wdv1WQyVGZy9mIsIyMw8VOw8lNy8lclRmcv9FdzVGdiojIklkclRmcvJye.xuOPf8ozhwdpfxZo2h1zTVZafhh0YKHG63uBlFdpl1GZ9HOWByk9PaIdfQtrAhea8A";
    String customerName = "Jerry";
    String orderNote = "Test Note";
    String orderCurrency = "INR";
    String appId = "1469829d60873d925cec9f77a1289641";
    String customerPhone = "1234567890";
    String customerEmail = "kerish.kumar@cashfree.com";
    String notifyUrl =
        "https://webhook.site/f3ce1ecc-fcad-4f7d-be99-d757aed07156";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,

      // EXTRA THINGS THAT NEEDS TO BE ADDED
      "paymentOption": "nb",
      "paymentCode":
          "3333", // Find Code here https://docs.cashfree.com/docs/net-banking
    };

    CashfreePGSDK.doPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
              //Do something with the result
            }));
  }

  // SEAMLESS - WALLET
  Future<void> seamlessWalletPayment() async {
    String orderId = "order_25_05_01";
    String stage = "PROD";
    String orderAmount = "100.0";
    String tokenData =
        "pH9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.Zv0nIxUTO1EmZlJmZkhjM2IiOiQHbhN3XiwSOzUjM3QzM1YTM6ICc4VmIsIiUOlkI6ISej5WZyJXdDJXZkJ3biwiIw4CMwEjI6ICduV3btFkclRmcvJCLiEDMfVDMfVjMfJXZkJ3biojIklkclRmcvJye.tLV4d__MTosRqoE1KkrLh-18RoiIAwe2HJFuKwne3YiXK62izvMgRyu27n7jUJcxFN";
    String customerName = "Test Customer";
    String orderNote = "Test Note";
    String orderCurrency = "INR";
    String appId = "145084e43c71b20eab47a2a4b80541";
    String customerPhone = "8755655022";
    String customerEmail = "test@gmail.com";
    String notifyUrl =
        "https://webhook.site/f3ce1ecc-fcad-4f7d-be99-d757aed07156";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,

      // EXTRA THINGS THAT NEEDS TO BE ADDED
      "paymentOption": "wallet",
      "paymentCode":
          "4001", // Find Code here https://docs.cashfree.com/docs/wallets
    };

    CashfreePGSDK.doPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
              //Do something with the result
            }));
  }

  // SEAMLESS - UPI
  Future<void> seamlessUPIPayment() async {
    String orderId = "prod_order_29_02";
    String stage = "PROD";
    String orderAmount = "1";
    String tokenData =
        "3m9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.7T9JSY2IWMmRjZ1YmYiJjNiojI0xWYz9lIsQjN2UDO0YTN2EjOiAHelJCLiIlTJJiOik3YuVmcyV3QyVGZy9mIsISMiojI05Wdv1WQyVGZy9mIsIiMw8VOy8lclRmcv9FZvJHciojIklkclRmcvJye.Nk7gCJat6jo0MYyfA5OKZ730bpgs0h33en7EhQocCXZPE94nIhsHR3kDdTt-g4QRcc";
    String customerName = "Dummy User";
    String orderNote = "Test Note";
    String orderCurrency = "INR";
    String appId = "145084e43c71b20eab47a2a4b80541";
    String customerPhone = "8755655022";
    String customerEmail = "kerish.kumar@cashfree.com";
    String notifyUrl = "https://api.bodhiness.com/v1/payment/cashfree/callback";
    String returnUrl =
        "https://www.bodhiness.com/payment?status=success&order_id={order_id}&order_token={order_token}";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,

      // EXTRA THINGS THAT NEEDS TO BE ADDED
      "paymentOption": "upi",
      "upi_vpa": "testsuccess@gocash"
    };

    CashfreePGSDK.doPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
              //Do something with the result
            }));
  }

  // SEAMLESS - Paypal
  Future<void> seamlessPayPalPayment() async {
    String orderId = "test_order_09_05_02";
    String stage = "TEST";
    String orderAmount = "100";
    String tokenData =
        "ux9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.sM0nIlRWMiVGOiZDM5cjM2IiOiQHbhN3XiwCN0cDM5YDN1YTM6ICc4VmIsIiUOlkI6ISej5WZyJXdDJXZkJ3biwiIwATMiojI05Wdv1WQyVGZy9mIsIiMw8VNw8VOw8lclRmcv9FdzVGdiojIklkclRmcvJye.RBdmF5BL-7h1rrJC2ZrdczFQUv11Yc7lBU23nQGZRj1eg08L8k2GeFMpEg6JTL8wzL";
    String customerName = "Dummy User";
    String orderNote = "Test Note";
    String orderCurrency = "INR";
    String appId = "1469829d60873d925cec9f77a1289641";
    String customerPhone = "1234567890";
    String customerEmail = "sample@gmail.com";
    String notifyUrl =
        "https://webhook.site/f3ce1ecc-fcad-4f7d-be99-d757aed07156";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,

      // EXTRA THINGS THAT NEEDS TO BE ADDED
      "paymentOption": "paypal"
    };

    CashfreePGSDK.doPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
              //Do something with the result
            }));
  }

  // UPI Intent
  Future<void> makeUpiPayment() async {
    //Replace with actual values
    String orderId = "prod_order_08_08_01";
    String stage = "PROD";
    String orderAmount = "1";
    String tokenData =
        "Mz9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.3r9JSYzYmY2QGMlJzYiJjNiojI0xWYz9lIsUjMwADM1YTN2EjOiAHelJCLiIlTJJiOik3YuVmcyV3QyVGZy9mIsISMiojI05Wdv1WQyVGZy9mIsISNw8lNw8VOy8lclRmcv9FZvJHciojIklkclRmcvJye.HsJwC_Ip6v-1gaRd-Y1TNwY-a9x-CodDtOY5KWa_ZOwdDaLra8BGUXQYfZ4jHx-MIS";
    String customerName = "Customer Name";
    String orderNote = "Order_Note";
    String orderCurrency = "INR";
    String appId = "145084e43c71b20eab47a2a4b80541";
    String customerPhone = "8755655022";
    String customerEmail = "skerish55@gmail.com";
    String notifyUrl =
        "https://webhook.site/f3ce1ecc-fcad-4f7d-be99-d757aed07156";
    String returnUrl =
        "https://www.bodhiness.com/payment?status=success&order_id={order_id}&order_token={order_token}";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,
      "returnUrl": returnUrl
    };

    CashfreePGSDK.doUPIPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
              //Do something with the result
            }));
  }

  // SEAMLESS UPI Intent
  Future<void> seamlessUPIIntent() async {
    //Replace with actual values
    String orderId = "prod_order_29_06_05";
    String stage = "PROD";
    String orderAmount = "1";
    String tokenData =
        "Mz9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.3r9JSYzYmY2QGMlJzYiJjNiojI0xWYz9lIsUjMwADM1YTN2EjOiAHelJCLiIlTJJiOik3YuVmcyV3QyVGZy9mIsISMiojI05Wdv1WQyVGZy9mIsISNw8lNw8VOy8lclRmcv9FZvJHciojIklkclRmcvJye.HsJwC_Ip6v-1gaRd-Y1TNwY-a9x-CodDtOY5KWa_ZOwdDaLra8BGUXQYfZ4jHx-MIS";
    String customerName = "Jerry";
    String orderNote = "Test Note";
    String orderCurrency = "INR";
    String appId = "145084e43c71b20eab47a2a4b80541";
    String customerPhone = "8755655022";
    String customerEmail = "skerish55@gmail.com";
    String notifyUrl =
        "https://webhook.site/f3ce1ecc-fcad-4f7d-be99-d757aed07156";
    String returnUrl =
        "https://www.bodhiness.com/payment?status=success&order_id={order_id}&order_token={order_token}";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,
      "returnUrl": returnUrl,
      // For seamless UPI Intent
      // "appName": _selectedApp["id"]
    };

    CashfreePGSDK.doUPIPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
              //Do something with the result
            }));
  }
}

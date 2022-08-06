import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:separate_api/app_controller.dart';
import 'package:separate_api/service/service_interface.dart';
import 'package:separate_api/service/services.dart';
import 'package:separate_api/ui/checkout/checkout.dart';
import 'package:separate_api/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CatalogCartAndCheckout(_getService())..init(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          "/home": (context) => const HomePage(),
          "/checkout": (context) => const CheckoutPage(),
        },
        home: const HomePage(),
      ),
    );
  }

  ServiceI _getService() {
    return Services(Api());
  }
}

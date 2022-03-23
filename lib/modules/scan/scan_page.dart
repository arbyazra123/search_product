import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:search_product/modules/product/detail_product_page.dart';

import '../home/models/product_model.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Color(0xFF212332),
        title: Text("Scan QR Code"),
      ),
      backgroundColor: Color(0xFF212332),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 100,
        color: Color(0xFF212332),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                controller?.toggleFlash();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.flash_auto,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Flash",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                controller?.resumeCamera();
                // _showModal(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.blur_circular_outlined,
                    color: Colors.white,
                    size: 55,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Refresh",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                controller?.flipCamera();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.change_circle_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Flip",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 4,
          width: MediaQuery.of(context).size.width * 9,
          child: QRView(
            key: qrKey,
            onQRViewCreated: (v) {
              controller = v;
              v.scannedDataStream.listen((event) {
                controller!.pauseCamera();
                result = event;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailProductPage(
                                product: Product.fromJson({
                              "id": 1,
                              "title":
                                  "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                              "price": 109.95,
                              "description":
                                  "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                              "category": "men's clothing",
                              "image":
                                  "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                              "rating": {"rate": 3.9, "count": 120}
                            }))));
              });
            },
          ),
        ),
      ),
    );
  }
}

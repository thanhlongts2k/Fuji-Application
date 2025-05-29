import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/home/views/detail_product_view.dart';
import '../controllers/home_controller.dart';
import 'widgets/data_grid.dart';
import 'widgets/header.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // ----------------------- Header ----------------------- //
            const Header(),
           Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20),
                child: Column(
                  children: [
                    // ----------------------- Attendance List Tile ----------------------- //
                    20.verticalSpace,
                    GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AiBarcodeScanner(
                              onDispose: () {
                                debugPrint("Barcode scanner disposed!");
                              },sheetTitle: 'Make a new Scan',
                              hideGalleryButton: false,
                              controller: MobileScannerController(
                                detectionSpeed: DetectionSpeed.noDuplicates,
                              ),
                              onDetect: (BarcodeCapture capture) {
                                final String? scannedValue =
                                    capture.barcodes.first.rawValue;
                                if (scannedValue != null) {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailScreen(sku: scannedValue),
                                    ),
                                  )
                                      .then((_) {
                                    Navigator.of(context).pop();
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 239, 71, 59),
                            borderRadius: BorderRadius.circular(6)),
                        child: const ListTile(
                          title: Text(
                            'Make a new Scan',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 17,
                            color: Colors.white,
                          ),
                          leading: Icon(
                            Icons.qr_code_scanner_sharp,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    DataGrid()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

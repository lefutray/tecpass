import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AccessCarsView extends StatelessWidget {
  const AccessCarsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: QrImage(
              backgroundColor: Colors.white,
              size: MediaQuery.of(context).size.width * 0.75,
              data: 'asdas',
              version: QrVersions.auto,
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.phone_iphone,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

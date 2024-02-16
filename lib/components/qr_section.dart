import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Qr { qrOnline, qrOffline }

Map<Qr, Widget> qrState = const {
  Qr.qrOnline: Text('QR Online'),
  Qr.qrOffline: Text('QR Offline'),
};

class QrSection extends StatefulWidget {
  const QrSection({Key? key}) : super(key: key);

  @override
  State<QrSection> createState() => _QrSectionState();
}

class _QrSectionState extends State<QrSection> {
  // Qr _selectedSegment = Qr.qrOnline;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Column(
          children:[
            // CupertinoSegmentedControl(
            //   borderColor: Colors.yellow.shade600,
            //   selectedColor: Colors.yellow.shade600,
            //   groupValue: _selectedSegment,
            //   children: const <Qr, Widget>{
            //     Qr.qrOnline: 
            //       Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            //       child: Text(
            //         'QR Online',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w500,
            //         ))
            //       ),
            //     Qr.qrOffline:  
            //       Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            //       child: Text(
            //         'QR Offline',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w500,
            //         ))
            //       ),
            //   },
            //   onValueChanged: (Qr value) {
            //     setState(() {
            //       _selectedSegment = value;
            //     });
            //   }
            // ),
            // const SizedBox(height: 30),
            // if (_selectedSegment == Qr.qrOnline)
            //   QrOnline()
            // else
            //   const QrOffline()
          ]
        )
      )
    );
  }
}
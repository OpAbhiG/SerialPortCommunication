// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter_libserialport/flutter_libserialport.dart';
//
// class SerialService {
//   SerialPort? port;
//   Function(String) onDataReceived;
//
//   SerialService(this.onDataReceived);
//
//   void startReading() {
//     final availablePorts = SerialPort.availablePorts;
//     if (availablePorts.isNotEmpty) {
//       port = SerialPort(availablePorts[0]); // Change this based on your device
//       if (port!.openReadWrite()) {
//         final reader = SerialPortReader(port!);
//         reader.stream.listen((Uint8List data) {
//           String rawData = utf8.decode(data);
//           onDataReceived(rawData.trim());
//         });
//       }
//     }
//   }
//
//   void stopReading() {
//     port?.close();
//   }
// }
//

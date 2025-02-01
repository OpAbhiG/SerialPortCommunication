import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:serial_data_app/main.dart';
import 'package:usb_serial/usb_serial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Oxygen Monitor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:     HomePage(),
    );
  }
}

//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   _HomePageState createState() => _HomePageState();
// }
// class _HomePageState extends State<HomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     List<String> avilablePort=SerialPort.availablePorts;
//     print('!!!!! avilable ports : $avilablePort !!!!!');
//     // SerialPort port=SerialPort(avilablePort[0]);
//     return Container();
//   }
//
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  UsbPort? _port;
  bool isConnected = false;
  String rawData = "Waiting for data...";
  int bloodOxygen = 0;
  int heartRate = 0;
  double bodyTemp = 0.0;

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  Future<void> _connectToDevice() async {
    try {
      List<UsbDevice> devices = await UsbSerial.listDevices();
      if (devices.isEmpty) {
        _updateStatus("No USB devices found");
        return;
      }

      _port = await devices[1].create();
      if (_port == null || !(await _port!.open())) {
        _updateStatus("Failed to open port");
        return;
      }

      // Corrected serial parameters here
      await _port!.setPortParameters(
        9600,
        8,  // Data bits (8 bits)
        1,  // Stop bits (1 stop bit)
        0,  // Parity (None)
      );

      setState(() => isConnected = true);
      _port!.inputStream?.listen((data) {
        final newData = String.fromCharCodes(data);
        _parseData(newData);
      });
    } catch (e) {
      _updateStatus("Error: ${e.toString()}");
    }
  }

  void _parseData(String data) {
    setState(() {
      rawData = data;
      final parts = data.split('|');
      if (parts.length == 3) {
        bloodOxygen = int.tryParse(parts[0]) ?? bloodOxygen;
        heartRate = int.tryParse(parts[1]) ?? heartRate;
        bodyTemp = double.tryParse(parts[2]) ?? bodyTemp;
      }
    });
  }

  void _updateStatus(String message) {
    setState(() {
      rawData = message;
      isConnected = false;
    });
  }

  @override
  void dispose() {
    _port?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blood Oxygen Monitor")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isConnected ? "Device Connected" : "Connection Failed",
              style: TextStyle(
                color: isConnected ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildMetricCard("Blood Oxygen", "$bloodOxygen%", Colors.blue),
            _buildMetricCard("Heart Rate", "$heartRate BPM", Colors.green),
            _buildMetricCard("Body Temperature", "${bodyTemp.toStringAsFixed(1)}°F", Colors.orange),
            const SizedBox(height: 20),
            Text("Raw Data: $rawData", style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: color, fontSize: 18)),
            const SizedBox(height: 10),
            Text(value, style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold
            )),
          ],
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_libserialport/flutter_libserialport.dart';
// // import 'package:serial_port/serial_port.dart';
// void main() => runApp(ExampleApp());
//
// class ExampleApp extends StatefulWidget {
//   @override
//   _ExampleAppState createState() => _ExampleAppState();
// }
//
// extension IntToString on int {
//   String toHex() => '0x${toRadixString(16)}';
//   String toPadded([int width = 3]) => toString().padLeft(width, '0');
//   String toTransport() {
//     switch (this) {
//       case SerialPortTransport.usb:
//         return 'USB';
//       case SerialPortTransport.bluetooth:
//         return 'Bluetooth';
//       case SerialPortTransport.native:
//         return 'Native';
//       default:
//         return 'Unknown';
//     }
//   }
// }
//
// class _ExampleAppState extends State<ExampleApp> {
//   var availablePorts = [];
//   SerialPort? selectedPort;
//   SerialPortReader? reader;
//   bool isConnected = false;
//
//   String rawData = "Waiting for data...";
//   int bloodOxygen = 0;
//   int heartRate = 0;
//   double bodyTemp = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _scanPorts();
//   }
//
//   Future<void> _scanPorts() async {
//     final ports = await SerialPort.availablePorts;
//     setState(() {
//       availablePorts = ports;
//     });
//
//     if (availablePorts.isNotEmpty) {
//       _connectToPort(availablePorts[0]); // Auto-connect to first port
//     }
//   }
//
//   Future<void> _connectToPort(String portName) async {
//     final port = SerialPort(portName);
//
//     try {
//       if (!await port.openReadWrite()) {
//         setState(() {
//           rawData = "Failed to open port";
//           isConnected = false;
//         });
//         return;
//       }
//
//       final config = SerialPortConfig();
//       config.baudRate = 9600;
//       config.bits = 8;
//       config.stopBits = 1;
//       config.parity = SerialPortParity.none;
//       // port.config = config;
//       port.config;
//
//
//       setState(() {
//         selectedPort = port;
//         isConnected = true;
//         rawData = "Connected to $portName";
//       });
//
//       reader = SerialPortReader(port);
//       reader!.stream.listen(_onDataReceived);
//     } catch (e) {
//       setState(() {
//         rawData = "Error: $e";
//         isConnected = false;
//       });
//     }
//   }
//
//   void _onDataReceived(Uint8List data) {
//     final receivedString = utf8.decode(data);
//     setState(() {
//       rawData = receivedString;
//
//       // Expected format: "98|72|36.5"
//       final parts = receivedString.split('|');
//       if (parts.length == 3) {
//         bloodOxygen = int.tryParse(parts[0]) ?? bloodOxygen;
//         heartRate = int.tryParse(parts[1]) ?? heartRate;
//         bodyTemp = double.tryParse(parts[2]) ?? bodyTemp;
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     selectedPort?.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter Serial Port example'),
//         ),
//         body: Scrollbar(
//           child: ListView(
//             children: [
//               for (final address in availablePorts)
//                 Builder(builder: (context) {
//                   final port = SerialPort(address);
//                   return ExpansionTile(
//                     title: Text(address),
//                     children: [
//                       CardListTile('Description', port.description),
//                       CardListTile('Transport', port.transport.toTransport()),
//                       CardListTile('USB Bus', port.busNumber?.toPadded()),
//                       CardListTile('USB Device', port.deviceNumber?.toPadded()),
//                       CardListTile('Vendor ID', port.vendorId?.toHex()),
//                       CardListTile('Product ID', port.productId?.toHex()),
//                       CardListTile('Manufacturer', port.manufacturer),
//                       CardListTile('Product Name', port.productName),
//                       CardListTile('Serial Number', port.serialNumber),
//                       SizedBox(height: 10,),
//                       CardListTile('available ports', availablePorts.toString()),
//
//                       Text(
//                         isConnected ? "Device Connected" : "Connection Failed",
//                         style: TextStyle(
//                           color: isConnected ? Colors.green : Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//
//                       const SizedBox(height: 20),
//                       _buildMetricCard("Blood Oxygen", "$bloodOxygen%", Colors.blue),
//                       _buildMetricCard("Heart Rate", "$heartRate BPM", Colors.green),
//                       _buildMetricCard("Body Temperature", "${bodyTemp.toStringAsFixed(1)}°F", Colors.orange),
//                       const SizedBox(height: 20),
//                       Text("Raw Data: $rawData", style: const TextStyle(color: Colors.grey)),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: _scanPorts,
//                         child: Text("Rescan Ports"),
//                       ),
//                     ],
//                   );
//                 }),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.refresh),
//           onPressed: _scanPorts,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMetricCard(String title, String value, Color color) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Text(title, style: TextStyle(color: color, fontSize: 18)),
//             const SizedBox(height: 10),
//             Text(value, style: TextStyle(
//                 color: color,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CardListTile extends StatelessWidget {
//   final String title;
//   final String? value;
//
//   CardListTile(this.title, this.value);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(title),
//       subtitle: Text(value ?? 'N/A'),
//     );
//   }
// }




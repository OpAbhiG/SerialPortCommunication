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
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UsbPort? _port;
  String _status = "Searching for device...";
  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  UsbDevice? _device;

  int bloodOxygen = 0;
  int heartRate = 0;
  double bodyTemp = 0.0;

  @override
  void initState() {
    super.initState();
    UsbSerial.usbEventStream!.listen((UsbEvent event) {
      _autoConnectDevice();
    });
    _autoConnectDevice();
  }

  Future<void> _autoConnectDevice() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();
    if (devices.isNotEmpty) {
      await _connectTo(devices.first);
    } else {
      setState(() {
        _status = "No USB device found";
      });
    }
  }

  Future<bool> _connectTo(UsbDevice device) async {
    _disconnect();

    _port = await device.create();
    if (await (_port!.open()) != true) {
      setState(() {
        _status = "Failed to open port";
      });
      return false;
    }

    _device = device;

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(9600, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
        _port!.inputStream as Stream<Uint8List>,
        Uint8List.fromList([13, 10])
    );

    _subscription = _transaction!.stream.listen((String line) {
      _parseSerialData(line);
    });

    setState(() {
      _status = "Connected";
    });
    return true;
  }

  void _parseSerialData(String data) {
    List<String> values = data.split('|');
    if (values.length >= 3) {
      setState(() {
        bloodOxygen = int.tryParse(values[0]) ?? 0;
        heartRate = int.tryParse(values[1]) ?? 0;
        bodyTemp = double.tryParse(values[2]) ?? 0.0;
      });
    }
  }

  void _disconnect() {
    _subscription?.cancel();
    _subscription = null;
    _transaction?.dispose();
    _transaction = null;
    _port?.close();
    _port = null;
    _device = null;
  }

  @override
  void dispose() {
    super.dispose();
    _disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('USB Serial Data')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_status, style: Theme.of(context).textTheme.titleLarge),
              _buildDataCard("Blood Oxygen", "$bloodOxygen%"),
              _buildDataCard("Heart Rate", "$heartRate BPM"),
              _buildDataCard("Body Temperature", "$bodyTemp °C"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataCard(String title, String value) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

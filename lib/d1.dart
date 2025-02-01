//////////////////////////////////////////////////////

// void main() => runApp(SensorApp());

// class SensorApp extends StatefulWidget {
//   @override
//   _SensorAppState createState() => _SensorAppState();
// }
//
// class _SensorAppState extends State<SensorApp> {
//   List<String> availablePorts = [];
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
//     setState(() {
//       availablePorts = SerialPort.availablePorts as List<String>;
//     });
//
//     if (availablePorts.isNotEmpty) {
//       _connectToPort(availablePorts[0]); // Auto-connect to first port
//     }
//   }
//
//   // void _connectToPort(String portName) async {
//   //   final port = SerialPort(portName);
//   //
//   //   if (!port.openReadWrite()) {
//   //     setState(() {
//   //       rawData = "Failed to open port";
//   //     });
//   //     return;
//   //   }
//   //
//   //   port.config = SerialPortConfig(
//   //      9600,
//   //      8,
//   //     1,
//   //     0,
//   //   );
//   //
//   //   setState(() {
//   //     selectedPort = port;
//   //     isConnected = true;
//   //     rawData = "Connected to $portName";
//   //   });
//   //
//   //   reader = SerialPortReader(port);
//   //   reader!.stream.listen(_onDataReceived);
//   // }
//
//
//   void _connectToPort(String portName) async {
//     final port = SerialPort(portName);
//
//     // Ensure port.open() returns a boolean before negating
//     bool isOpened = port.open(mode: SerialPortMode.readWrite) as bool;
//
//     if (!isOpened) {
//       setState(() {
//         rawData = "Failed to open port";
//       });
//       return;
//     }
//
//     // Configure port settings
//     final config = SerialPortConfig();
//     config.baudRate = 9600;
//     config.bits = 8;
//     config.stopBits = 1;
//     config.parity = SerialPortParity.none;
//
//     // Apply the configuration correctly
//     port.config;
//
//     setState(() {
//       selectedPort = port;
//       isConnected = true;
//       rawData = "Connected to $portName";
//     });
//
//     // Start reading data (ensure that the stream is awaited or handled properly)
//     reader = SerialPortReader(port);
//     reader!.stream.listen((data) {
//       _onDataReceived(data);
//     });
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
//     _scanPorts();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Health Sensor Monitor")),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 isConnected ? "Device Connected" : "Connection Failed",
//                 style: TextStyle(
//                   color: isConnected ? Colors.green : Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildMetricCard("Blood Oxygen", "$bloodOxygen%", Colors.blue),
//               _buildMetricCard("Heart Rate", "$heartRate BPM", Colors.green),
//               _buildMetricCard("Body Temperature", "${bodyTemp.toStringAsFixed(1)}°F", Colors.orange),
//               const SizedBox(height: 20),
//               Text("Raw Data: $rawData", style: const TextStyle(color: Colors.grey)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _scanPorts,
//                 child: Text("Rescan Ports"),
//               ),
//             ],
//           ),
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

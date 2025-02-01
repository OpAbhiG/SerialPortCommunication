// import 'package:flutter/material.dart';
// import 'package:flutter_libserialport/flutter_libserialport.dart';
//
// import 'io_port_page.dart';
// // import 'package:serial_port_app/io_port_page.dart';
//
//
// class PortsPage extends StatefulWidget {
//   const PortsPage({super.key});
//
//   @override
//   State<PortsPage> createState() => _PortsPageState();
// }
//
// class _PortsPageState extends State<PortsPage> {
//   List<String> availablePorts = ["COM1", "COM2"];
//
//   @override
//   void initState() {
//     super.initState();
//     initPorts();
//   }
//
//   void initPorts() {
//     print(SerialPort.availablePorts);
//     setState(
//           () => {
//         availablePorts.addAll(SerialPort.availablePorts as Iterable<String>),
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(247, 13, 16, 20),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         margin: EdgeInsets.all(20),
//         constraints: BoxConstraints(),
//         child: Scrollbar(
//             child: ListView(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Center(
//                     child: Text(
//                       "Available Ports",
//                       style: TextStyle(
//                         fontSize: 21,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 for (final port in availablePorts)
//                   Builder(
//                     builder: (context) {
//                       return Container(
//                         margin: const EdgeInsets.fromLTRB(20, 3, 10, 3),
//                         decoration: BoxDecoration(
//                             border: Border.all(width: 2, color: Colors.white),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: ListTile(
//                           textColor: Colors.white,
//                           title: Text(port),
//                           leading: const Icon(Icons.settings),
//                           iconColor: Colors.green[500],
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => IOPortPage(
//                                   portName: port,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//               ],
//             )),
//       ),
//     );
//   }
// }

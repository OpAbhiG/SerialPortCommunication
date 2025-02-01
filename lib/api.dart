// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class ApiService {
//   static const String apiUrl = "https://your-server.com/api/upload"; // Change to your API URL
//
//   static Future<void> sendData(int bloodOxygen, int heartRate, double bodyTemp) async {
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "blood_oxygen": bloodOxygen,
//           "heart_rate": heartRate,
//           "body_temp": bodyTemp,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         print("Data sent successfully!");
//       } else {
//         print("Failed to send data: ${response.body}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
// }

# USB Serial Device Integration for Bharat TeleClinic

![Bharat TeleClinic](![btlogowhite](https://github.com/user-attachments/assets/9af6e0e1-0b3e-4468-8b6b-55455335c5ff)) <!-- Add a relevant image or logo -->

![Device](![image](https://github.com/user-attachments/assets/1cc002f7-3d30-4487-8e88-2c98dc46fd3a)) <!-- Add a relevant image or logo -->
![image](https://github.com/user-attachments/assets/0b146d0f-cc70-4920-a876-6f069181b8ee)

## 📌 Overview
This project is a **Flutter-based application** that integrates with a **USB serial device** to automatically read and display patient vitals such as:
- 🩸 **Blood Oxygen Levels (SpO₂)**
- ❤️ **Heart Rate (BPM)**
- 🌡 **Body Temperature (°C)**

This system is a **core part of the Bharat TeleClinic project**, ensuring seamless and real-time health monitoring.

## 🚀 Features
✅ **Auto-Connect to USB Device** – No manual connection required. The app automatically detects and connects to the first available serial device.
✅ **Real-time Data Display** – Reads and displays blood oxygen, heart rate, and temperature.
✅ **Smooth UI Design** – Clean, user-friendly interface with Flutter.
✅ **Error Handling** – Handles device disconnection scenarios gracefully.
✅ **Easy Customization** – Modify and expand features as needed.

## 🛠️ Tech Stack
- **Flutter** (Dart)
- **USB Serial Communication**
- **Material Design UI**

## 📂 Project Structure
```
/your_project
│── /lib
│   ├── main.dart  # Main application logic
│   ├── usb_handler.dart  # Handles USB connections
│   ├── ui_components.dart  # UI widgets like data cards
│── pubspec.yaml  # Flutter dependencies
│── README.md  # Project Documentation
```

## 📦 Dependencies
Add the following to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  usb_serial: ^0.3.0  # Ensure compatibility
```

## 🚀 Getting Started
1. **Clone the Repository:**
   ```sh
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo
   ```
2. **Install Dependencies:**
   ```sh
   flutter pub get
   ```
3. **Run the App:**
   ```sh
   flutter run
   ```

## 🖥️ Screenshots
| USB Connection | Live Vitals |
|---------------|------------|
| ![USB Connect]) | ![Vitals Display](https://your-image-url.com/vitals.png) |
![WhatsApp Image 2025-02-02 at 00 14 30_61a13d05](https://github.com/user-attachments/assets/601f4f60-c7b7-4238-9980-71c633ef35fb)


## 👨‍💻 Contribution
Want to improve this project? Contributions are welcome!
1. Fork the repository.
2. Create a new branch: `git checkout -b feature-name`
3. Commit your changes: `git commit -m "Added new feature"`
4. Push to the branch: `git push origin feature-name`
5. Submit a pull request 🎉

## 📜 License
This project is licensed under the **MIT License**.

---

**🔥 Developed for Bharat TeleClinic** | 💡 _Revolutionizing Digital Healthcare_


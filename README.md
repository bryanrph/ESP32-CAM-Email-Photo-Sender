# ESP32-CAM Telegram Bot

Create a Telegram bot to interact with your ESP32-CAM and request photos remotely. You can control your ESP32-CAM from anywhere using Telegram on your smartphone - you just need internet access.

## Project Overview

This project demonstrates how to:
- Create a Telegram bot for your ESP32-CAM
- Request photos remotely via Telegram commands
- Control the ESP32-CAM flash LED via Telegram
- Receive photos directly in your Telegram chat
- Secure the bot to only respond to authorized users

### Features

- **/start** - Receive a welcome message with available commands
- **/photo** - Request the ESP32-CAM to take and send a new photo
- **/flash** - Toggle the ESP32-CAM's LED flash on/off
- **Security** - Only responds to messages from your authorized Telegram account ID

### Hardware Requirements

- ESP32-CAM (AI-Thinker model with OV2640 camera)
- USB-to-Serial adapter for programming (or ESP32-CAM-MB programmer)
- Power supply (5V, 2A recommended)
- Micro USB cable for programming
- WiFi router with internet access

### Software Requirements

- Arduino IDE (version 1.8.19 or later recommended)
- ESP32 Board Support Package
- Universal Telegram Bot Library by Brian Lough
- ArduinoJson Library

## Resources

### Libraries Required

1. **Universal Telegram Bot Library** by Brian Lough
   - **Important:** Don't install through Arduino Library Manager (may install deprecated version)
   - Download from: [GitHub Releases](https://github.com/witnessmenow/Universal-Arduino-Telegram-Bot/releases)
   - Install via: Arduino IDE → Sketch → Include Library → Add .ZIP Library
   - Select the downloaded ZIP file

2. **ArduinoJson Library**
   - Install via: Arduino IDE → Sketch → Include Library → Manage Libraries
   - Search for "ArduinoJson"
   - Install version 6.15.2 or compatible

### Documentation Links

- [Random Nerd Tutorials - Telegram ESP32-CAM Photo Tutorial](https://randomnerdtutorials.com/telegram-esp32-cam-photo-arduino/)
- [Universal Arduino Telegram Bot Library](https://github.com/witnessmenow/Universal-Arduino-Telegram-Bot)
- [ESP32-CAM Pinout Guide](https://randomnerdtutorials.com/esp32-cam-pinout-gpios-pinreference/)

## Installation Instructions

### Step 1: Install Arduino IDE

1. Download Arduino IDE from [arduino.cc](https://www.arduino.cc/en/software)
2. Install the IDE on your computer

### Step 2: Add ESP32 Board Support

1. Open Arduino IDE
2. Go to **File → Preferences**
3. In "Additional Board Manager URLs", add:
   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
4. Go to **Tools → Board → Boards Manager**
5. Search for "ESP32" and install "esp32 by Espressif Systems"
6. Recommended version: 2.0.10 or 3.0.7 (version 3.3.0+ may have compatibility issues)
7. **Important:** Go to **Tools → PSRAM** and enable it

### Step 3: Install Required Libraries

1. **Universal Telegram Bot Library:**
   - Download the latest release from [GitHub](https://github.com/witnessmenow/Universal-Arduino-Telegram-Bot/releases)
   - Go to **Sketch → Include Library → Add .ZIP Library**
   - Select the downloaded ZIP file
   - **Do NOT install via Library Manager** (may install deprecated version)

2. **ArduinoJson Library:**
   - Go to **Sketch → Include Library → Manage Libraries**
   - Search for "ArduinoJson"
   - Install the library (version 6.15.2 recommended)

### Step 4: Create a Telegram Bot

1. Download and install **Telegram** on your smartphone or computer
2. Open Telegram and search for **"botfather"** or open [t.me/botfather](https://t.me/botfather)
3. Click **Start** to begin a conversation with BotFather
4. Type **/newbot** and follow the instructions
5. Give your bot a name (e.g., "My ESP32-CAM Bot")
6. Give your bot a username (must end with "bot", e.g., "my_esp32cam_bot")
7. **Save the bot token** - you'll need it for the Arduino code
   - The token looks like: `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`

### Step 5: Get Your Telegram User ID

1. In Telegram, search for **"IDBot"** or open [t.me/myidbot](https://t.me/myidbot)
2. Start a conversation and type **/getid**
3. The bot will reply with your user ID (a number like `123456789`)
4. **Save this user ID** - you'll need it to authorize your account

### Step 6: Configure the Code

1. Open `ESP32_CAM_Telegram_Bot.ino` in Arduino IDE
2. Update the following settings:

```cpp
// WiFi Credentials
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

// Telegram Bot Token (from BotFather)
String BOTtoken = "YOUR_BOT_TOKEN_HERE";

// Your Telegram User ID (from @myidbot)
String CHAT_ID = "YOUR_CHAT_ID_HERE";
```

3. **Important:** 
   - Replace `YOUR_WIFI_SSID` with your WiFi network name
   - Replace `YOUR_WIFI_PASSWORD` with your WiFi password
   - Replace `YOUR_BOT_TOKEN_HERE` with the token from BotFather
   - Replace `YOUR_CHAT_ID_HERE` with your user ID from @myidbot

### Step 7: Select Board and Upload Settings

1. Go to **Tools → Board → ESP32 Arduino → AI Thinker ESP32-CAM**
2. Select the correct **Port** (Tools → Port → [Your COM port])
3. Set **Upload Speed** to **115200** (Tools → Upload Speed)
4. **Enable PSRAM:** Go to **Tools → PSRAM → Enabled**
5. If you encounter upload issues, try **921600** or lower speeds

### Step 8: Upload the Code

1. Connect your ESP32-CAM to your computer via USB
2. **Hold the RESET button** on the ESP32-CAM
3. Click **Upload** in Arduino IDE
4. Release the RESET button when you see "Connecting..." in the IDE
5. Wait for the upload to complete

### Step 9: Test the Project

1. Open **Serial Monitor** (Tools → Serial Monitor)
2. Set baud rate to **115200**
3. Press the RESET button on the ESP32-CAM
4. Watch the Serial Monitor for:
   - WiFi connection status
   - Camera initialization
   - IP address assignment
5. Open Telegram and search for your bot (using the username you created)
6. Click **Start** to begin a conversation
7. Send **/start** to receive the welcome message
8. Send **/photo** to request a photo
9. Send **/flash** to toggle the flash LED

## Troubleshooting

### Common Issues and Solutions

#### 1. "Camera init failed" Error
**Problem:** Camera initialization fails with error code

**Solutions:**
- Check all camera connections (ensure camera module is properly seated)
- Verify you selected the correct board: **AI Thinker ESP32-CAM**
- **Enable PSRAM:** Go to Tools → PSRAM → Enabled
- Try downgrading ESP32 board package to version 2.0.10:
  1. Tools → Board → Boards Manager
  2. Search "ESP32"
  3. Select version 2.0.10 and install
- Try lowering the frame size in the code:
  ```cpp
  config.frame_size = FRAMESIZE_SVGA;  // Instead of FRAMESIZE_UXGA
  ```
- Ensure adequate power supply (use external 5V, 2A power supply if possible)
- Check if camera model pins are correctly defined for your board

#### 2. WiFi Connection Failed
**Problem:** ESP32-CAM doesn't connect to WiFi

**Solutions:**
- Verify SSID and password are correct (case-sensitive)
- Ensure WiFi is 2.4GHz (ESP32-CAM doesn't support 5GHz)
- Move ESP32-CAM closer to the router
- Check router settings (some routers block new devices)
- Try restarting your router

#### 3. Telegram Bot Not Responding
**Problem:** Bot doesn't respond to commands

**Solutions:**
- Verify you clicked **Start** on the bot in Telegram (required before bot can message you)
- Check that `BOTtoken` is correct (from BotFather)
- Verify `CHAT_ID` matches your user ID (from @myidbot)
- Check Serial Monitor for error messages
- Ensure ESP32-CAM is connected to WiFi (check IP address in Serial Monitor)
- Verify internet connectivity

#### 4. "Unauthorized user" Message
**Problem:** Bot responds with "Unauthorized user"

**Solutions:**
- Your `CHAT_ID` doesn't match the sender's ID
- Get your correct user ID using @myidbot
- Update `CHAT_ID` in the code with your actual user ID
- Re-upload the code

#### 5. Photo Not Sending / Connection Failed
**Problem:** Photo request doesn't send photo or connection fails

**Solutions:**
- Check Serial Monitor for connection errors
- Verify internet connectivity
- Check that bot token is correct
- Ensure camera is working (test with Serial Monitor output)
- Try requesting photo again (first photo may be low quality and is disposed)
- Check if image size is too large (may need to adjust quality settings)

#### 6. "WRITE_PERI_REG" Compilation Errors
**Problem:** Compiler errors about WRITE_PERI_REG or missing definitions

**Solutions:**
- Update your ESP32 board package to version 2.0.10 or 3.0.7
- If using version 3.3.0+, try downgrading to 2.0.10
- Ensure all required libraries are installed:
  - `esp_camera.h` (should come with ESP32 board package)
  - `UniversalTelegramBot.h`
  - `ArduinoJson.h`

#### 7. Upload Fails / Timeout Errors
**Problem:** Code won't upload to ESP32-CAM

**Solutions:**
- **Hold RESET button** while uploading (critical step)
- Try different USB cables (some cables are charge-only)
- Lower upload speed: Tools → Upload Speed → 115200
- Disconnect and reconnect USB cable
- Try a different USB port
- If using ESP32-CAM-MB programmer, ensure proper jumper configuration
- Put ESP32-CAM into download mode manually:
  1. Hold BOOT button
  2. Press and release RESET button
  3. Release BOOT button

#### 8. Brownout Detector Errors
**Problem:** ESP32 restarts due to insufficient power

**Solutions:**
- Use external 5V power supply (at least 2A)
- Don't rely solely on USB power if possible
- If using USB, ensure it's a high-quality cable and port
- The code includes `WRITE_PERI_REG(RTC_CNTL_BROWN_OUT_REG, 0);` to disable brownout detector (use with caution)

#### 9. Low Quality Images
**Problem:** Photos sent to Telegram are low quality

**Solutions:**
- The code disposes the first photo (often low quality) and takes a second one
- Adjust JPEG quality in `configInitCamera()`:
  ```cpp
  config.jpeg_quality = 10;  // Lower number = higher quality (0-63)
  ```
- Ensure PSRAM is enabled (Tools → PSRAM → Enabled)
- Use UXGA frame size if PSRAM is available

### Serial Monitor Debug Information

The Serial Monitor will show:
- WiFi connection progress
- Camera initialization status
- Telegram bot message handling
- Photo capture and sending status
- Connection errors and responses
- Success/failure notifications

## Code Structure

- `setup()`: Initializes serial, flash LED, camera, and WiFi connection
- `configInitCamera()`: Configures and initializes the ESP32-CAM camera
- `handleNewMessages()`: Processes incoming Telegram messages and executes commands
- `sendPhotoTelegram()`: Captures photo and sends it to Telegram via HTTPS
- `loop()`: Continuously checks for new Telegram messages

## Features

- Remote photo capture via Telegram commands
- Flash LED control via Telegram
- Secure bot (only responds to authorized user)
- Real-time photo delivery to Telegram
- Serial debugging output
- Error handling and status reporting

## Security Notes

- The bot only responds to messages from the authorized `CHAT_ID`
- Unauthorized users receive an "Unauthorized user" message
- To allow multiple users, you can modify the code to check against a list of authorized IDs
- For group chats, you can get the group chat ID using @myidbot

## License

This code is based on the work by Rui Santos & Sara Santos - Random Nerd Tutorials.
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files.

## References

- Original Tutorial: [Telegram: ESP32-CAM Take and Send Photo (Arduino IDE)](https://randomnerdtutorials.com/telegram-esp32-cam-photo-arduino/)
- Universal Telegram Bot Library: [GitHub Repository](https://github.com/witnessmenow/Universal-Arduino-Telegram-Bot)
- ESP32-CAM Documentation: [Random Nerd Tutorials](https://randomnerdtutorials.com/esp32-cam-introduction/)

## Contributing

Feel free to submit issues and enhancement requests!

## Author

Based on tutorial by Rui Santos & Sara Santos - Random Nerd Tutorials

---

## YOUR_NAME : NOTES FOR CSN150

### Purpose:


### Equipment Used:


### Tools used: 
Arduino, GPTx, etc...


### Steps I Followed:


### Problems / Solutions: 


### Final Report:


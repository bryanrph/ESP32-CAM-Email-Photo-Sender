# ESP32-CAM Email Photo Sender

Send captured photos from ESP32-CAM directly to your email using SMTP (Simple Mail Transfer Protocol). This project captures a photo when the ESP32-CAM boots and automatically sends it as an email attachment.

## Project Overview

This project demonstrates how to:
- Capture photos using the ESP32-CAM module
- Store photos in LittleFS filesystem
- Send photos via email using Gmail SMTP server
- Handle email authentication with app passwords

### Hardware Requirements
- ESP32-CAM (AI-Thinker model with OV2640 camera)
- USB-to-Serial adapter for programming (or ESP32-CAM-MB programmer)
- Power supply (5V, 2A recommended)
- Micro USB cable for programming
- WiFi router with internet access

### Software Requirements
- Arduino IDE (version 1.8.19 or later recommended)
- ESP32 Board Support Package
- ESP-Mail-Client library by Mobizt

## Resources

### Libraries Required
1. **ESP-Mail-Client** by Mobizt
   - Install via: Arduino IDE → Sketch → Include Library → Manage Libraries → Search "ESP Mail Client"
   - Version: Latest (3.4.24 or newer)

### Documentation Links
- [Random Nerd Tutorials - ESP32-CAM Send Photos via Email](https://randomnerdtutorials.com/esp32-cam-send-photos-email/)
- [ESP-Mail-Client Library Documentation](https://github.com/mobizt/ESP-Mail-Client)
- [ESP32-CAM Pinout Guide](https://randomnerdtutorials.com/esp32-cam-pinout-gpios-pinreference/)

### Email Provider SMTP Settings

#### Gmail SMTP Settings
- **SMTP Server:** smtp.gmail.com
- **SMTP Port (SSL):** 465
- **SMTP Port (TLS):** 587
- **TLS/SSL Required:** Yes

#### Outlook SMTP Settings
- **SMTP Server:** smtp.office365.com
- **SMTP Port:** 587
- **TLS/SSL Required:** Yes

#### Hotmail/Live SMTP Settings
- **SMTP Server:** smtp.live.com
- **SMTP Port:** 587
- **TLS/SSL Required:** Yes

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
6. Recommended version: 3.0.7 or later (version 3.3.0+ may have compatibility issues)

### Step 3: Install Required Libraries
1. Go to **Sketch → Include Library → Manage Libraries**
2. Search for "ESP Mail Client"
3. Install **ESP Mail Client by Mobizt** (latest version)
4. The library should automatically include LittleFS support

### Step 4: Configure Gmail Account (2-Step Verification & App Password)

#### Enable 2-Step Verification
1. Go to your [Google Account](https://myaccount.google.com/)
2. Click on **Security** in the left navigation panel
3. Under "Signing in to Google", find **2-Step Verification**
4. Click **Get started** and follow the on-screen steps to enable 2-Step Verification
   - You'll need to verify your phone number
   - Complete the setup process

#### Create App Password
1. After enabling 2-Step Verification, return to **Security** settings
2. In the search bar at the top, search for **"App Passwords"**
3. Click on **App Passwords** (or go directly to [App Passwords](https://myaccount.google.com/apppasswords))
4. If prompted, sign in again and verify your identity
5. Under "Select app", choose **"Mail"** (or "Other (Custom name)")
6. Under "Select device", choose **"Other (Custom name)"** and type "ESP32-CAM"
7. Click **"Generate"**
8. A 16-character password will appear in a pop-up window
9. **IMPORTANT:** Copy this password immediately (format: `xxxx xxxx xxxx xxxx` - 4 groups of 4 characters)
10. Save it securely - you'll need it for the Arduino code
11. Click **"Done"**

**Note:** The app password shown is a one-time display. If you lose it, you'll need to generate a new one.

### Step 5: Configure the Code
1. Open `ESP32_CAM_Send_Photo_Email.ino` in Arduino IDE
2. Update the following settings:

```cpp
// WiFi Credentials
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

// Email Settings
#define emailSenderAccount    "your-email@gmail.com"  // Gmail account with app password
#define emailSenderPassword   "xxxx xxxx xxxx xxxx"   // 16-character app password (with spaces)
#define smtpServer            "smtp.gmail.com"
#define smtpServerPort        465
#define emailSubject          "ESP32-CAM Photo Captured"
#define emailRecipient        "recipient-email@gmail.com"  // Where to send photos
```

3. **Important:** Use the app password (not your regular Gmail password) in `emailSenderPassword`
4. The app password format should include spaces: `xxxx xxxx xxxx xxxx`

### Step 6: Select Board and Upload Settings
1. Go to **Tools → Board → ESP32 Arduino → AI Thinker ESP32-CAM**
2. Select the correct **Port** (Tools → Port → [Your COM port])
3. Set **Upload Speed** to **115200** (Tools → Upload Speed)
4. If you encounter upload issues, try **921600** or lower speeds

### Step 7: Upload the Code
1. Connect your ESP32-CAM to your computer via USB
2. **Hold the RESET button** on the ESP32-CAM
3. Click **Upload** in Arduino IDE
4. Release the RESET button when you see "Connecting..." in the IDE
5. Wait for the upload to complete

### Step 8: Test the Project
1. Open **Serial Monitor** (Tools → Serial Monitor)
2. Set baud rate to **115200**
3. Press the RESET button on the ESP32-CAM
4. Watch the Serial Monitor for:
   - WiFi connection status
   - Camera initialization
   - Photo capture confirmation
   - Email sending status

## Troubleshooting

### Common Issues and Solutions

#### 1. "Camera init failed" Error
**Problem:** Camera initialization fails with error code

**Solutions:**
- Check all camera connections (ensure camera module is properly seated)
- Verify you selected the correct board: **AI Thinker ESP32-CAM**
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

#### 3. Email Sending Failed / Authentication Error
**Problem:** Email fails to send with authentication errors

**Solutions:**
- **Most Common:** You're using your regular Gmail password instead of an app password
  - Generate a new app password following Step 4 above
  - Make sure 2-Step Verification is enabled first
- Verify app password format (should include spaces: `xxxx xxxx xxxx xxxx`)
- Check that `emailSenderAccount` is the complete Gmail address
- Ensure app password hasn't expired (unlikely, but possible)
- Try generating a new app password if the current one doesn't work
- Verify SMTP settings match your email provider (Gmail uses port 465 with SSL)

#### 4. "LittleFS mount failed" or File System Errors
**Problem:** Errors like "Corrupted dir pair" or "mount failed"

**Solutions:**
- This is usually a library version issue
- Ensure you're using **ESP-Mail-Client** (not the older ESP32-Mail-Client)
- Try downgrading ESP32 board package to version 3.0.7:
  1. Tools → Board → Boards Manager
  2. Search "ESP32"
  3. Select version 3.0.7 and install
- The LittleFS plugin is NOT required - files are created via code

#### 5. "WRITE_PERI_REG" Compilation Errors
**Problem:** Compiler errors about WRITE_PERI_REG or missing definitions

**Solutions:**
- Update your ESP32 board package to the latest stable version
- If using version 3.3.0+, try downgrading to 3.0.7
- Ensure all required libraries are installed:
  - `esp_camera.h` (should come with ESP32 board package)
  - `ESP_Mail_Client.h`
  - `FS.h` and `LittleFS.h` (included with ESP32)

#### 6. Email Received but No Attachment
**Problem:** Email sends successfully but photo attachment is missing

**Solutions:**
- Check Serial Monitor for file save confirmation
- Verify file was saved: Look for "The picture has been saved" message
- Ensure LittleFS is working properly (see issue #4 above)
- Check file path: Should be `/photo.jpg`
- Verify photo file size in Serial Monitor (should be > 0 bytes)

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

### Email Service Configuration Notes

#### Gmail-Specific Configuration
- **App Passwords are MANDATORY** for Gmail - regular passwords won't work
- 2-Step Verification must be enabled before you can create app passwords
- App passwords are 16 characters, displayed as 4 groups of 4 (include spaces in code)
- Each app password can only be viewed once - save it immediately
- You can revoke app passwords anytime from Google Account security settings

#### Security Recommendations
- **Use a dedicated Gmail account** for ESP32 projects (not your main account)
- This prevents issues if the app password is compromised
- If something goes wrong and too many emails are sent, only the test account is affected
- Your main email can still be the recipient

#### Alternative Email Providers
- **Outlook/Office365:** Similar app password process via Microsoft Account security
- **Hotmail/Live:** Use Live Account security settings for app passwords
- **Other providers:** Search for "[Your Provider] SMTP settings app password"

### Serial Monitor Debug Information
Enable debug mode in the code to see detailed email sending information:
```cpp
smtp.debug(1);  // Set to 1 for basic debug, 0 for none
```

The Serial Monitor will show:
- WiFi connection progress
- Camera initialization status
- Photo capture details (file size, path)
- Email sending progress
- SMTP server responses
- Success/failure notifications

## Code Structure

- `setup()`: Initializes WiFi, camera, captures photo, and sends email
- `capturePhotoSaveLittleFS()`: Takes photo and saves to LittleFS
- `sendPhoto()`: Configures SMTP and sends email with attachment
- `smtpCallback()`: Callback function for email sending status

## Features

- Automatic photo capture on boot
- Photo storage in LittleFS filesystem
- Email sending with attachment via SMTP
- Support for Gmail, Outlook, and other SMTP providers
- Serial debugging output
- Error handling and status reporting

## License

This code is based on the work by Rui Santos & Sara Santos - Random Nerd Tutorials.
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files.

## References

- Original Tutorial: [ESP32-CAM Send Photos via Email](https://randomnerdtutorials.com/esp32-cam-send-photos-email/)
- ESP-Mail-Client Library: [GitHub Repository](https://github.com/mobizt/ESP-Mail-Client)
- ESP32-CAM Documentation: [Random Nerd Tutorials](https://randomnerdtutorials.com/esp32-cam-introduction/)

## Contributing

Feel free to submit issues and enhancement requests!

## Author

Based on tutorial by Rui Santos & Sara Santos - Random Nerd Tutorials


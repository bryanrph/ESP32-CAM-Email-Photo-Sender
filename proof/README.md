# Proof of Concept

This folder contains proof that the ESP32-CAM Email Photo Sender project works successfully.

## Example Photo

The photo in this folder was:
- Captured by an ESP32-CAM module
- Saved to LittleFS filesystem
- Successfully sent via email using Gmail SMTP
- Received in Gmail inbox as an attachment

**Email Details:**
- **From:** ESP32-CAM <bryanrph2@gmail.com>
- **Subject:** ESP32-CAM Photo Captured
- **Status:** ✅ Successfully sent and received

This demonstrates that the project successfully:
1. Initializes the ESP32-CAM camera
2. Captures a photo
3. Connects to WiFi
4. Authenticates with Gmail SMTP using app password
5. Sends the photo as an email attachment
6. Delivers the email successfully


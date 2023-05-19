## Firmware

Clone: https://github.com/braingram/Lapse-O-Matic/tree/ai_thinker_no_wifi

Open firmware: `Lapse-O-Matic/Lapse-O-Matic_FIRMWARE/Lapse-O-Matic/Lapse-O-Matic.ino`

### IDE setup

Install Arduino IDE (I did all testing with 1.8.14)

install esp32 board support: https://github.com/espressif/arduino-esp32

When programming select the following options in the Arduino IDE Tools menu:

- Board: AI-thinker-esp32-camera
- CPU Frequency: 240 MHz
- Flash Frequency: 80 MHz
- Flash Mode: QIO
- Partition Scheme: Huge APP
- Core Debug Level: None

### Programming

For programming:

- Bridge program pins (see the hardware.md document for more detalis)
- apply power
- upload firmware (this should detect and program the RTC).


### Debug output

The default baud rate is 115200 and some debug information is output during
operation (determined in part by the `DEBUG_FLAG` and `DEBUG_PHOTO` settings).
Otherwise currently there is no control over the serial port.


### SD Card

The settings are read from the SD card. This card is also where the photos
(and log data) will be saved. First, format the card for Fat32. Then create
a text file on the card named `settings.txt` with the following:

```
// Adjust these settings as required: //

FLASH_FLAG = 0

NUMBER_PHOTOS = 1

TIME_TO_SLEEP = 10

MODE = TRIGGER

PHOTO_DELAY = 0

FLASH_START_DELAY = 10

FLASH_STOP_DELAY = 10
 
DEBUG_FLAG = 1

DEBUG_PHOTO = 1


// END OF SETTINGS - LEAVE THIS LINE  //
```

Install and remove the card only when the ESP32 is unpowered.

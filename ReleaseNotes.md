# UNO-220 Raspberry Pi 4 Image Builder Release Notes

- Version: 0.0.2
- Date: 2020/10/27
---

## Feature List 
 - SSH server enabled 
 - RTC-RX8010
 - TI TCA9554 IO extender
 - Serial to RS-232/485
 - Based on 2020-08-20-raspios-buster-armhf-full.img

---

## Change List
 - Version 0.0.2 (2020/10/27): 
   - RTC driver supports for multiple kernel versions and the latest version 1.20201022-1. 
   - Add Debian packages for rtc, serial and gpio. 
 - Version 0.0.1 (2020/10/23): 
   - Image base changed to 2020-08-20-raspios-buster-armhf-full.img. 
 - Version 0.0.1 (2020/04/30): 
   - Enable hdmi_force_hotplug in configs.txt. 
 - Version 0.0.1 (2020/03/02): 
   - Fix the system time not synchronized with realtime clock hardware when boot-up. 
 - Version 0.0.1 (2020/02/10): 
   - Enable SSH server by default.  
   - Create Raspbian full image for Advantech UNO-220 IO Board. 

---

## How to test UNO-220

  - Inset SD card and power on Raspberry Pi 4, and check your DHCP 
     environment for Pi's IP.

  - Connect your Pi by ssh. (Default login: pi/raspberry)
     
     ```
     $ ssh pi@${Pi_IP}    # Pi_IP: Pi's IP address
     ```
  - RTC
 
    - Get RTC time
      ```
      pi@raspberrypi:~ $ sudo hwclock -r
      2020-01-13 06:34:43.545566+00:00
      ```
    - Set RTC by system time
      ```
      pi@raspberrypi:~ $ sudo hwclock -w
      ```
    
  - GPIO (uno220gpio)

    - Show usage
    
      ```
      pi@raspberrypi:~ $ sudo uno220gpio -h
      Usage:
        uno220gpio --export=[all|0~7]                  # Export GPIO
        uno220gpio --unexport=[all|0~7]                # Unexport GPIO
        uno220gpio --pin=[0~7] --direction=[in|out]    # Set GPIO Direction
        uno220gpio --pin=[0~7]                         # GPIO Read Operation
        uno220gpio --pin=[0~7] --value=[0|1]           # GPIO Write Operation
        uno220gpio --status
      ```
    
    - Get all GPIO Status
    
      ```
      pi@raspberrypi:~ $ sudo uno220gpio
       pin       |   0   1   2   3   4   5   6   7
      ---------------------------------------------
       export    |   0   0   0   0   0   0   0   0
       direction |   X   X   X   X   X   X   X   X
       value     |   X   X   X   X   X   X   X   X
      ```

    - Export all
    
      ```
      pi@raspberrypi:~ $ sudo uno220gpio --export=all
      pi@raspberrypi:~ $ sudo uno220gpio
       pin       |   0   1   2   3   4   5   6   7
      ---------------------------------------------
       export    |   1   1   1   1   1   1   1   1
       direction |   I   I   I   I   I   I   I   I
       value     |   1   1   1   1   1   1   1   1
      ```
    
    - Set direction (ex: pin=0, direction=out)
    
      ```
      pi@raspberrypi:~ $ sudo uno220gpio --pin=0 --direction=out
      pi@raspberrypi:~ $ sudo uno220gpio
       pin       |   0   1   2   3   4   5   6   7
      ---------------------------------------------
       export    |   1   1   1   1   1   1   1   1
       direction |   O   I   I   I   I   I   I   I
       value     |   0   0   1   1   1   1   1   1
      ```
    
    - Set value (ex: pin=0, direction=out, value=1)
    
      ```
      pi@raspberrypi:~ $ sudo uno220gpio --pin=0 --value=1
      pi@raspberrypi:~ $ sudo uno220gpio
       pin       |   0   1   2   3   4   5   6   7
      ---------------------------------------------
       export    |   1   1   1   1   1   1   1   1
       direction |   O   I   I   I   I   I   I   I
       value     |   1   1   1   1   1   1   1   1
      ```

  - Serial port test - PC (Ubuntu 16.04 x86-64) vs Pi 
    Connect PC's RS-232 TxD/RxD/GND pins connect to IO Board corresponding pins. 

    - PC send data to Pi 

      - Pi side command: 
        ```
        pi@raspberrypi:~ $ sudo uno220uartrecv 
        ```
      - PC side command:
        ```
        $ ./files/host-x86_64/host_send /dev/ttyUSB0 $(echo -ne "\x01\x02\x03")
        ```
   
        Then, Pi will show received data prompt. 

    - PC send data to Pi 

      - PC side command:
        ```
        $ sudo ./host_recv /dev/ttyUSB0
        ```
   
      - Pi side command: 
        ```
        pi@raspberrypi:~ $ sudo uno220uartsend /dev/ttyS0 $(echo -ne "\x01\x02\x03")
        ```
        Then, Pi will show received data prompt. 

---


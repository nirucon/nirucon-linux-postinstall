# Nirucon Linux Post Install

Post Install script for my Linux setups.

### Disclaimer and Warning
1. I do not take any responsibility for this script or any changes/problems it might cause on your system!
2. I am not a professional programmer, hacker, or tech expert. I am an old n00b who uses Linux as my daily driver and sometimes enjoys tinkering with my setup to make it easier for myself.
3. Consider this script a work in progress. But there is a risk that it may not be improved or updated at all, and I cannot offer any guarantees.

### Dependencies
If not listed here - YOU are responsible to look in the script.

### Related scripts
- [nirucon-alpi](https://github.com/nirucon/nirucon-alpi)
- [nirucon-vlpi](https://github.com/nirucon/nirucon-vlpi)
- [nirucon-dlpi](https://github.com/nirucon/nirucon-dlpi)

## About

This script helps to set up a Linux system with custom post-install configurations. It supports the following distributions:
- **Arch Linux** (the largest script and most 'complete' setup - my daily driver)
  - Focused on suckless dwm setup, noir theming, DAW and media production
- **Void Linux** (minimal setup - works for me)
  - suckless dwm setup
- **Debian Linux** (minimal setup - WORK IN PROGRESS)
  - suckless dwm setup

This script and related scripts are created for personal use but are free to use and modify. It is designed to use `startx` and `.xinitrc` with Suckless DWM as the window manager. It does not support login managers such as SDDM and similar. If you need those, you will have to configure them yourself. Please proceed with caution as the script modifies your system settings!

## Usage

### 1. Display Welcome Message

The script will display a welcome message with information about the script and the supported distributions.

### 2. Check Internet Connection

The script will check if there is an active internet connection. If no connection is detected, the script will exit.

### 3. Prompt Confirmation to Proceed

The script will prompt the user to confirm whether to proceed with the installation. If the user declines, the script will exit.

### 4. Detect Linux Distribution

The script will detect the Linux distribution to determine the appropriate post-installation script to use.

### 5. Clone and Start the Post Install Script

Based on the detected distribution, the script will clone the corresponding post-install script repository and start the installation process.

## Running the Script

To run the script, save it as `nirucon-linux-postinstall.sh`, make it executable, and then execute it:

```bash
chmod +x nirucon-linux-postinstall.sh
./nirucon-linux-postinstall.sh
```

## License
Feel free to use and modify this script. Donations are welcome and appreciated: [PayPal](https://www.paypal.com/paypalme/nicklasrudolfsson)

## Contact
- **Author**: Nicklas Rudolfsson
- **GitHub**: [nirucon](https://github.com/nirucon)
- **Email**: [n@rudolfsson.net](mailto:n@rudolfsson.net)

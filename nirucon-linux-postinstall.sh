#!/bin/bash

# nirucon-linux-postinstall: Post Install script for Arch, Void and Debian based Linux
# Author: Nicklas Rudolfsson
# Version: 2024-08-03
# License: Feel free to use and modify, donate if you want :) https://www.paypal.com/paypalme/nicklasrudolfsson
# Disclaimer: I do not have any responsibility at all for this script and changes on your system!

# Function: Display welcome message
display_welcome() {
    clear
    echo -e "\e[1;34mWelcome to the Nirucon Linux Post Install script!\e[0m"
    echo -e "\e[1;31mDisclaimer: Use at your own risk. NO responsibility for changes made to your system.\e[0m"
    echo "--------------------------------------------------------------------------"
    echo "The script:"
    echo "Will help me/you set up a Linux system with my custom post install configurations."
    echo "\n"
    echo "Supports:"
    echo "Arch Linux (the largest script and most 'complete' setup - my daily driver)"
    echo "- Focused on suckless dwm setup, noir theming, DAW and media production"
    echo "Void Linux (minimal setup - works BUT WORK IN PROGRESS)"
    echo "- suckless dwm setup"
    echo "Debian Linux (minimal setup - works BUT WORK IN PROGRESS)"
    echo "- suckless dwm setup"
    echo "\n”
    echo "This script and related scripts are created by me for my personal use, but they are free to use and modify."
    echo "It is designed to use startx and .xinitrc with Suckless DWM as the window manager."
    echo "It does not support login managers such as SDDM and similar. If you need those, you will have to configure them yourself."
    echo "Please proceed with caution as the script modifies your system settings!"
    echo "--------------------------------------------------------------------------"
}

# Function: Check for internet connection
check_internet_connection() {
    echo "Checking internet connection..."
    if ping -q -c 1 -W 1 google.com >/dev/null; then
        echo "Internet connection: OK"
    else
        echo "Internet connection: OFFLINE"
        echo "This script requires an active internet connection. Please resolve the issue and run the script again."
        exit 1
    fi
}

# Function: Prompt confirmation to proceed
confirm_proceed() {
    read -p "Are you sure you want to continue with the installation? This script is provided without any warranties. Proceed at your own risk! [Y/n]: " confirm_install
    confirm_install=${confirm_install:-Y}
    if [[ "$confirm_install" != [Yy]* ]]; then
        echo "Installation aborted by the user."
        exit 0
    fi
}

# Function: Detect Linux distribution
detect_distro() {
    echo "The script will now check what Linux distribution you have..."
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        if [ "$DISTRO" == "void" ]; then
            if ! ldd --version 2>&1 | grep -q 'GNU libc'; then
                DISTRO="unsupported"
            fi
        fi
    elif [ -f /etc/debian_version ]; then
        DISTRO="debian"
    elif [ -f /etc/arch-release ]; then
        DISTRO="arch"
    else
        DISTRO="unsupported"
    fi
    echo "Detected Linux distribution: $DISTRO"
}

# Function: Clone and start the post install script based on the detected distro
clone_and_start_script() {
    case $DISTRO in
        arch)
            REPO_URL="https://github.com/nirucon/nirucon-alpi"
            SCRIPT="nirucon-alpi"
            ;;
        debian|ubuntu)
            REPO_URL="https://github.com/nirucon/nirucon-dlpi"
            SCRIPT="nirucon-dlpi"
            ;;
        void)
            REPO_URL="https://github.com/nirucon/nirucon-vlpi"
            SCRIPT="nirucon-vlpi"
            ;;
        *)
            echo "Sorry, this script and related scripts only support Arch Linux (systemd), Void Linux (glibc, runit), and Debian (systemd) based distributions."
            exit 1
            ;;
    esac

    # Create the ~/Git directory if it does not exist
    mkdir -p ~/Git

    # Remove the existing cloned directory if it exists
    if [ -d "~/Git/$SCRIPT" ]; then
        rm -rf "~/Git/$SCRIPT"
    fi

    echo "Cloning the post installation script from $REPO_URL to ~/Git..."
    git clone "$REPO_URL" "~/Git/$SCRIPT"

    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository. Please check your internet connection and try again."
        exit 1
    fi

    echo "Post installation script for your Linux version ($DISTRO) is cloned and will now start."
    cd "~/Git/$SCRIPT"

    # List contents of the cloned directory to debug the issue
    echo "Contents of the cloned directory:"
    ls -l

    # Set execute permission on the script
    chmod +x ./$SCRIPT

    if [ -f ./$SCRIPT ]; then
        ./$SCRIPT
    else
        echo "$SCRIPT not found in the cloned directory."
        exit 1
    fi
}

# Main function to execute the script
main() {
    display_welcome
    check_internet_connection
    confirm_proceed
    detect_distro
    clone_and_start_script
}

main

#!/bin/bash

# Nirucon Linux Post Install script by Nicklas Rudolfsson.
# WARNING:
# Work in progress! I'm an old noob and definitely not a pro at Linux or bash scripting.
# Only supports Arch Linux (systemd) based distributions at the moment!
# Coming "soon": support for Void Linux (glibc, runit) and Debian (systemd) based distributions.

# Function: Display welcome message
display_welcome() {
    echo "Welcome to Nirucon Linux Post Install script by Nicklas Rudolfsson."
    echo "The script:"
    echo "- Will help you set up your Linux system with my custom post install configurations."
    echo "- This script and related scripts are created by me for my personal use, but they are free to use and modify."
    echo "However, do not expect any support, and I take no responsibility for any issues that may arise on your system due to this script!"
    echo "The script is designed to use startx and .xinitrc with Suckless DWM as the window manager."
    echo "It does not support login managers such as SDDM and similar. If you need those, you will have to configure them yourself."
    echo "Please proceed with caution as the script modifies your system settings!"
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
            ;;
        debian|ubuntu)
            REPO_URL="https://github.com/nirucon/nirucon-dlpi"
            ;;
        void)
            REPO_URL="https://github.com/nirucon/nirucon-vlpi"
            ;;
        *)
            echo "Sorry, this script and related scripts only support Arch Linux (systemd) based, Void Linux (glibc), and Debian based distributions."
            exit 1
            ;;
    esac

    echo "Cloning the post installation script from $REPO_URL..."
    git clone "$REPO_URL" ~/nirucon-postinstall-script

    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository. Please check your internet connection and try again."
        exit 1
    fi

    echo "Post installation script for your Linux version ($DISTRO) is cloned and will now start."
    cd ~/nirucon-postinstall-script
    ./postinstall.sh
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

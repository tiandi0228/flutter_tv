#!/usr/bin/env bash

APP_NAME="TV"
DMG_FILE_NAME="${APP_NAME}-Installer.dmg"
VOLUME_NAME="${APP_NAME} Installer"
SOURCE_FOLDER_PATH="build/macos/Build/Products/Release/"

# Create the DMG
create-dmg \
  --volname "${VOLUME_NAME}" \
  --background "installer_background.jpg" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "flutter_tv.app" 260 250 \
  --hide-extension "flutter_tv.app" \
  --app-drop-link 600 185 \
  "${DMG_FILE_NAME}" \
  "${SOURCE_FOLDER_PATH}"
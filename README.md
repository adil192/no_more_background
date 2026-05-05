# App Manager

A graphical interface for managing Android applications via ADB.

## Install

### Linux

#### Prerequisites

Ensure the following dependencies are installed:

- `adb` (Android Debug Bridge)
- Flutter runtime (for building from source)

On Debian/Ubuntu-based distributions:
```bash
sudo apt install android-tools-adb flutter
```

On Arch Linux:
```bash
sudo pacman -S android-tools flutter
```

On Fedora:
```bash
sudo dnf install android-tools flutter
```

On Alt Linux:
```bash
sudo apt-get install android-tools-adb flutter
```

Or using epm:
```bash
epm install android-tools-adb flutter
```

#### Quick Installation

Run this one-line command to install App Manager:

```bash
git clone --recurse-submodules https://github.com/otetswoo/app_manager.git && cd app_manager && flutter pub get && flutter build linux && ./build/linux/x64/release/bundle/app_manager
```

#### Building from Source

1. Install Flutter following the official instructions: https://flutter.dev/docs/get-started/install

2. Clone this repository with its submodules:
   ```bash
   git clone --recurse-submodules https://github.com/otetswoo/app_manager.git
   cd app_manager
   ```

3. Get the dependencies:
   ```bash
   flutter pub get
   ```

4. Build the application:
   ```bash
   flutter build linux
   ```

5. Run the application:
   ```bash
   ./build/linux/x64/release/bundle/app_manager
   ```

## Usage

1. Connect your Android device to your computer with a USB cable.

2. Enable USB debugging on your Android device:
   - Go to Settings → About phone
   - Tap "Build number" 7 times to enable Developer options
   - Go to Settings → System → Developer options
   - Enable "USB debugging"

3. Launch App Manager and select your device from the list. If your device doesn't appear, ensure USB debugging is enabled and check the connection.

4. You'll see a list of installed applications. From here you can:
   - Install APK files by clicking the install button
   - Uninstall applications via the context menu
   - Manage background restrictions and data access permissions

5. When finished, you can safely disconnect your device.

## Building from source

See the "Install" section above for instructions on building the application manually.

## Licenses

This project uses the following third-party works:

- This repository is licensed under the [GPL-3.0-or-later](LICENSE.md) license.
- Android is a trademark of Google LLC.
- The green Android robot in the application icon was reproduced and modified based on work created and shared by Google, used according to terms described in the [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/) license.
- Illustrations from [CocoMaterial](https://cocomaterial.com/) under the [CC0 1.0](assets/cocomaterial/LICENSE) license.
- App icons from [Delta-Icons](https://github.com/Delta-Icons/android), licensed under the [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/) license.
- App display names from [lawnicons](https://github.com/LawnchairLauncher/lawnicons), licensed under the [Apache-2.0](https://github.com/LawnchairLauncher/lawnicons/blob/develop/LICENSE) license.
- Device images from [lineage_wiki](https://github.com/LineageOS/lineage_wiki), licensed under the [MIT](https://github.com/LineageOS/lineage_wiki/blob/main/licenses/LICENSE) license.

View the full list of licenses within the application by navigating to "About this app" → "View licenses".

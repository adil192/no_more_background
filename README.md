# NoMoreBackground

A fire-and-forget program to stop Android™ apps from running in the background.

## Translate

If you wish to bring NoMoreBackground to more people, please contribute translations on our [Weblate page](https://hosted.weblate.org/engage/no_more_background/):

[![Translation status](https://hosted.weblate.org/widget/no_more_background/no_more_background/multi-auto.svg)](https://hosted.weblate.org/engage/no_more_background/)

## Install

[<img src=".github/assets/badges/f-droid-badge.svg"
    alt="Get it on F-Droid"
    height=50>](https://f-droid.org/en/packages/com.adilhanney.no_more_background/)
&nbsp;
[<img src=".github/assets/badges/obtainium-badge.png"
    alt="Get it on Obtainium"
    height=50>](https://apps.obtainium.imranr.dev/redirect?r=obtainium://app/%7B%22id%22%3A%22com.adilhanney.no_more_background%22%2C%22url%22%3A%22https%3A%2F%2Fgithub.com%2Fadil192%2Fno_more_background%22%2C%22author%22%3A%22adil192%22%2C%22name%22%3A%22NoMoreBackground%22%2C%22preferredApkIndex%22%3A0%7D)
&nbsp;
[<img src=".github/assets/badges/windows-badge.png"
    alt="Download for Windows"
    height=50>](https://github.com/adil192/no_more_background/releases/latest/download/NoMoreBackground-Windows-x64.zip)
&nbsp;
[<img src=".github/assets/badges/flathub-badge.svg"
    alt="Download on Flathub"
    height=50>](https://flathub.org/apps/com.adilhanney.no_more_background)

Install NoMoreBackground on...
1. Linux

   Search for NoMoreBackground in your app store or go to https://flathub.org/apps/com.adilhanney.no_more_background
2. Windows

   Download the latest [NoMoreBackground-Windows-x64.zip](https://github.com/adil192/no_more_background/releases/latest/download/NoMoreBackground-Windows-x64.zip),
   extract it somewhere, and run `no_more_background.exe`.
3. Android (no computer needed)

   Setup Shizuku with these instructions: https://shizuku.rikka.app/guide/setup/.

   Then install NoMoreBackground from https://f-droid.org/en/packages/com.adilhanney.no_more_background/

## Usage

If using Windows, install `adb` on your computer. `adb` is already bundled on Linux so this step isn't necessary.

Connect your Android device to your computer with a cable.
In `no_more_background`, tap your device in the list. If you don't see your device, you may wish to check out Google's [troubleshooting guide](https://developer.android.com/studio/run/device#troubleshoot).

![](metadata/en-US/images/flathubScreenshots/1_connect.png)

You'll see a list of apps installed on your device.
Use the checkboxes to choose which apps can run in the background, and which apps can access data in the background.

![](metadata/en-US/images/flathubScreenshots/2_apps.png)

That's it! Close no_more_background and move on with your life.

## Manual method

no_more_background is just a convenient way to manage all your apps in one place, but you can do the exact same thing manually on the Android device.

For each app:
1. Open Settings → Apps → [Find your app].
2. In "App battery usage", disable "Allow background usage".
3. In "Mobile data usage", disable "Background data".

You have to repeat this process for each app, which quickly becomes tedious. no_more_background exposes these settings all in one page to make the process a little less painful.

## Building from source

1. [Install Flutter](https://flutter.dev/docs/get-started/install), e.g. with my script:
    ```bash
    curl -s https://raw.githubusercontent.com/adil192/adil192-linux/main/bootstrap/install_flutter.sh | bash
    ```
2. Clone this repository with its submodules:
    ```bash
    git clone --recurse-submodules https://github.com/adil192/no_more_background.git
    cd no_more_background
    ```
3. Get the dependencies:
    ```bash
    flutter pub get
    ```
4. Build the app:
    ```bash
    flutter build linux
    ```
5. Run the app:
    ```bash
    ./build/linux/x64/release/bundle/no_more_background
    ```

## Licenses

Here is a subset of some of the works that are used with NoMoreBackground.
Please view the license page in-app for the full list.

- This repo, except for NoMoreBackground's icon,
  is licensed under the [GPL-3.0-or-later](LICENSE.md) license.
- Android is a trademark of Google LLC.
- The green Android robot in NoMoreBackground's icon was reproduced and modified
  based on work created and shared by Google and used according to terms described
  in the [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/) license.
  Therefore, the NoMoreBackground icon is also licensed under the
  [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/) license.
- Illustrations from [CocoMaterial](https://cocomaterial.com/)
  under the [CC0 1.0](assets/cocomaterial/LICENSE) license.
- App icons from [Delta-Icons](https://github.com/Delta-Icons/android),
  licensed under the [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/) license.
- App display names from [lawnicons](https://github.com/LawnchairLauncher/lawnicons),
  licensed under the [Apache-2.0](https://github.com/LawnchairLauncher/lawnicons/blob/develop/LICENSE) license,
  plus some display names from NoMoreBackground under its GPL-3.0-or-later license.
- Device images from [lineage_wiki](https://github.com/LineageOS/lineage_wiki),
  licensed under the [MIT](https://github.com/LineageOS/lineage_wiki/blob/main/licenses/LICENSE) license.
- You can view the full list of licenses in the app by clicking "About this app" then "View licenses".

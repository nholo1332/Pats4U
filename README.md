<h1 align="center">
  <br>
  <img src="https://github.com/nholo1332/Pats4U/blob/main/assets/images/CLPats.png?raw=true" alt="Pats4U" width="200">
  <br>
  Pats4U
  <br>
</h1>

<h4 align="center">Providing the Patriot Nation with an app that serves every need. Created with <a href="https://flutter.dev" target="_blank">Flutter</a>.</h4>

<p align="center">
  <a href="#app-icon">App Icon</a> •
  <a href="#about">About</a> •
  <a href="#key-features">Key Features</a> •
  <a href="#future-plans">Future Plans</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#why-flutter">Why Flutter?</a> •
  <a href="#credits">Credits</a>
</p>


## App Icon

Our app logo reflects our school's mascot, the Patriots. We used this app icon, for everyone in our community can easily recognize and create the association from the app to the school.


## About

The Pats4U application allows users to view Patriot announcements, events, weekly breakfast and lunch menus, and easily contact staff.


## Key Features

* Feed
  - View impoortant recent updates from the school, from game scores to school announcements.
* Events
  - View school events and even add your own to the calendar section of the app.
* Menu
  - The breakfast and lunch menus are available to view for the week, with optional food images.
* Staff
  - The staff view makes it easy to learn more about the Patriot staff and contact them.
* Local Caching System
  - The local app data cache allows caching data for offline viewing.
* Dark Mode
  - The automatic dark mode (based on device settings) will make viewing the app late at night easier, and it saves you battery on newer devices.

## Future Plans
In the event we are able to continue developing this app for release or advancement to the National Leadership Conference, we thought of features we would like to add. These features were in the initial plan, but due to time restrictions, were unable to be added.

* User Onboarding View
  - Create a view to explain to users the advantages or creating an app account. Another view could be added to display the features of the app.
* Reminders
  - Set event reminders.
* Notifications
  - Allow receiving notifications from the school, using FCM and the Backend service.


## How To Use

To clone and run this backend service, you will need [Git](https://git-scm.com) and [Flutter](https://flutter.dev/docs/get-started/install), and Xcode (for iOS) installed on your computer. Next, run these commands:

```bash
# Clone this repository (or download the file from GitHub)
$ git clone https://github.com/nholo1332/Pats4U.git

# Go into the repository
$ cd Pats4U

# Install dependencies
$ flutter pub get

# Run the development app
$ flutter run
```
Make sure you have a supported device connected that is trusted on your computer. If you need to use a simulator, use Android Studio, or test on iOS using the commands below:
```
# Build for iOS
$ flutter build --ios
```
Then, open Xcode and navigate to the project to open the `Runner.xcworkspace`. From there, select your target device and click run.


## Why Flutter?

There are many platforms that allow cross-platform (non-native) development, so why did we choose Flutter?
* Devlopment Speed
  - Flutter has hot reload, so once you make a change and save it, the app will automatically reload and your changes are visible almost instantly.
* Two App at Once
  - When writing code, we write it for both Android and iOS at the same time - dramatically cutting down on development time.
* Customization
  - Flutter allows for easily creating your own widgets to make creative and unique designs.
* Compatibility
  - Because Flutter creates its own widgets, the app will look the same on all devices, regardless of age.
* Expanding Support
  - Flutter has also caught the eye of many other developers. This helps the Flutter ecosystem as more developers mean more awesome dependencies available to us.


## Credits

All dependencies can be found in the `pubspec.yaml` file. All licenses can be found on the licenses view in the app.

The application, logos, and ideas were created by the FBLA Mobile App Development team from the Clarkson-Leigh FBLA chapter - Mitchel Beeson, Noah Holoubek, and Samuel Pocasangre.

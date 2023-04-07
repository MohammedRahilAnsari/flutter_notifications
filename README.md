# flutter_notification

This Project serves the purpose of guiding,
how to use firebase notification in flutter for [android] and [ios].

## Getting Started

To begin add dependencies in [pubspec.yaml],
reference available in project yaml.

# [Android] setup

1. Check minSdkVersion supported by [firebase core] version you are using.
2. Firebase core supports minSdkVersion 19.
3. Replace example in package name with [company/firm] name as example will cause problem later.
4. Update/Change [applicationId] to provide unique name to your project.

# firebase console 

Go to firebase console create a [project] on console to begin with firebase notification.
Once the project is ready in firebase console let's being.

## Firebase Notification FCM/push notification - [android] 

1. Select android and register the app.
2. Download the [google-service.json] and move to next step, add the downloaded file in [android/app] folder.
3. Copy the dependencies and paste it in Root-level (project-level) Gradle file (<project>/build.gradle)/ [android/build.gradle].
4. Next Step is to add some dependencies in Module (app-level) Gradle file (<project>/<app-module>/build.gradle): [android/app/build.gradle].
5. finish the console setup.

with above points we have successfully completed the [android] part.

# [IOS] setup

1. Open Podfile located in [ios] folder and uncomment [platform :ios, '11.0'] make sure the version is set to 11.
2. Go to Info.plist which is located in [ios/Runner],
   1. Search for [CFBundleIdentifier].
   2. Copy android package name and paste it in between [<string>] tag.

Make sure to use same bundle as it'll be difficult to manage 1 project with different package name.
Right click on [ios] folder and select open in finder -> open ios folder and then [Runner.xcworkspace] in [xcode]

## Firebase Notification FCM/push notification - [ios]

1. Select ios and register app.
2. Download the [google-service.json] and move to next step, add [google-service.json] inside [Runner] folder.
3. Open [Runner] switch tab to [Signing & Capabilities], inside Signing make sure the [Bundle Identifier] is same as Android Package.
4. Disable Automatically manage signing. 
5. Now, Switch back to general and check [Bundle Identifier] and check if it is similar to the previous [Bundle Identifier].
6. Come back to [your code Editor] eg [Android studio/vscode].
7. Open [Terminal] and navigate to [IOS] folder. Type [cd ios] and hit Enter.
8. As we did changes in [IOS] we have to update our Podfile, Type [pod update] in terminal and hit Enter. 

## Initializing Firebase

1. Go to [main.dart]
2. Inside void main() function we have to bind our widget first before initializing anything. we can bind our widget by calling [WidgetsFlutterBinding.ensureInitialized()].
3. Next is we will initialize our firebase by calling an async function [Firebase.initializeApp()].

## Notification Service 

1. We will separate our notification code by using [NotificationService] class.
2. Follow the [NotificationService] class for detail guidance.
3. Created instance of [NotificationService] class in Homepage.dart.

## Adding In App Notification [Foreground Notification]

1. Add Meta in Android [Manifest] file.
2. We have to Initialize [flutter_local_notification] plugin, this plugin will take care of user interface of notification.
3. Create [inAppNotificationInit] method which will read the notification and update UI. (This is a Stream).

## Adding background Notification 

1. To add support for background notification, simply copy and paste entry point code available in main.dart.
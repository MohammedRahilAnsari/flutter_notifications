# flutter_notification

This Project serves the purpose of guiding,
how to use firebase notification in flutter for [android] and [ios].

## Getting Started

To begin add dependencies in [pubspec.yaml],
reference available in project yaml.

## Android App level Gradle

check minSdkVersion supported by [firebase core] version you are using.

replace example in package name with [company/firm] name as example will cause problem later.
update/set [applicationId] to provide unique name to your project

### firebase console ##

Go to firebase console create a [project] on console to begin with firebase notification.
Once the project is ready in firebase console let's being.

# starting with [android] 

1. Select android and register the app.
2. Download the [google-service.json] and move to next step, add the downloaded file in [android/app] folder.
3. Copy the dependencies and paste it in Root-level (project-level) Gradle file (<project>/build.gradle)/ [android/gradle/build.gradle].
4. Next Step is to add some dependencies in Module (app-level) Gradle file (<project>/<app-module>/build.gradle): [android/app/build.gradle].
5. finish the console setup.

with above points we have successfully completed the [android] part.


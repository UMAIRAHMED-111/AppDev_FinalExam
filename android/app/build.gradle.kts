// File: android/app/build.gradle.kts

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services") // ✅ Required for Firebase services
    id("dev.flutter.flutter-gradle-plugin") // ✅ Flutter plugin
}

android {
    namespace = "com.example.app_dev_final_exam"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456" // ✅ Required by Firebase plugins

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.app_dev_final_exam"
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // 🔐 Replace with release signing in production
        }
    }
}

flutter {
    source = "../.."
}

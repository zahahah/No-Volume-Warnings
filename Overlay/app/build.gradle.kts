import java.util.Properties

plugins {
    alias(libs.plugins.android.application) }

val signingPropertiesFile = file(
    System.getenv("NVW_KEYSTORE_PROPERTIES")
        ?: "/Users/raf/Developer/signature-keys/No-Volume-Warnings/keystore.properties")
val signingProperties = Properties().apply {
    check(signingPropertiesFile.isFile) {
        "Missing signing properties at ${signingPropertiesFile.absolutePath}. " +
            "Create it or set NVW_KEYSTORE_PROPERTIES."
    }
    signingPropertiesFile.inputStream().use(::load)
}

fun signingProperty(name: String): String =
    checkNotNull(signingProperties.getProperty(name)) {
        "Missing $name in ${signingPropertiesFile.absolutePath}"
    }

android {
    lint {
        checkReleaseBuilds = false }

    namespace = "lightningzahah.NoVolumeWarnings"
    compileSdk {
        version = release(26) }
    signingConfigs {
        create("release") {
            storeFile = file(signingProperty("storeFile"))
            storePassword = signingProperty("storePassword")
            keyPassword = signingProperty("keyPassword")
            keyAlias = signingProperty("keyAlias") }}
    defaultConfig {
        applicationId = "lightningzahah.NoVolumeWarnings"
        minSdk = 26
        targetSdk = 26
        versionCode = 100
        versionName = "1.0.0"
        signingConfig = signingConfigs.getByName("release")}

    buildTypes {
        release {
            isMinifyEnabled = false }}}

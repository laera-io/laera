# Release

* [Automatic](#automatic)
* [Manual](#manual)
* [Signing](#signing)
  * [Generate New `.jks` File](#generate-new-jks-file)
  * [`keystore.properties` File](#keystoreproperties-file)
  * [Generate `.pem` Certificate](#generate-pem-certificate)
  * [Generate Data For CI/CD](#generate-data-for-cicd)

## Automatic

* Update app version at `pubspec.yaml`;
* Add changelog to `android/fastlane/metadata/android/en-US/changelogs/`, name of the file is a commits number of `stable` branch (including commit in which the changelog will be added);
* Update some `.txt` files if needed at `android/fastlane/metadata/android/en-US/`;
* Update screenshots and other graphic at `android/fastlane/metadata/android/en-US/images/`;
* Commit all the changes;
* Create GitHub release with `v` prefix (for example `v1.2.3`).

## Manual

* Create new `keys` dir by running `mkdir -p android/fastlane/keys`;
* Put there some files:
  * `google_play_api_key.json` - api key from `https://play.google.com/console/u/<user_id>/developers/<dev_id>/api-access`, [docs][google_play_api_key_docs];
  * `keystore.jks` - [signing key](#generate-new-jks-file);
  * `keystore.properties` - [properties for `keystore.jks`](#keystoreproperties-file);
* Install Ruby dependencies as intended in [development.md file](development.md#ruby-optional);
* Build `make build-aab`;
* Upload to Google Play Console.

## Signing

* Signing key must be registered into Google Play Console before using;
* Signing key must be a 2048 bit RSA key and have 25-year validity.

### Generate New `.jks` File

```sh
keytool -genkeypair -alias <alias_name> -keyalg RSA -keysize 2048 -validity 9125 -keystore keystore.jks
```

### `keystore.properties` File

```txt
storeFile=../fastlane/keys/keystore.jks
storePassword=<jks_password>
keyAlias=<alias_name>
keyPassword=<jks_password>
```

### Generate `.pem` Certificate

```sh
keytool -export -rfc -alias <alias_name> -file upload_certificate.pem -keystore keystore.jks
```

### Generate Data For CI/CD

```sh
base64 -w 0 <file_name>
```

[google_play_api_key_docs]: https://developers.google.com/android-publisher/getting_started

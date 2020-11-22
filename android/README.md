# Laera. Android

## Release build

### Before the first building

* Create `[project_root]/android/fastlane/keys` directory;
* Put there some files:
  * `google_play_api_key.json` - api key from `https://play.google.com/console/u/2/developers/<dev_id>/api-access`
  * `keystore.jks` - signing key
  * `keystore.properties` - properties for `keystore.jks`
* Install `ruby` and `gem`
* `cd android` - move to `[project_root]/android` directory
* `bundle install` - install gem file dependencies

### Build

* `cd android` - move to `[project_root]/android` directory
* `bundle exec fastlane build` - the built app will be at `[project_root]/build/app/outputs/bundle/release/app-release.aab`

## Signing

> Signing key must be a 2048 bit RSA key and have 25-year validity

### Generate .jks file

```sh
keytool -genkeypair -alias <alias_name> -keyalg RSA -keysize 2048 -validity 9125 -keystore keystore.jks
```

### Generate .pem certificate

```sh
keytool -export -rfc -alias <alias_name> -file upload_certificate.pem -keystore keystore.jks
```

### Generate data for CI/CD

```sh
base64 -w 0 <file_name>
```

## Helpful links

* [Flutter cd][flutter_cd]
* [Fastlane recipe][fastlane_recipe]
* [Creating google play api key docs][google_play_api_key_docs]
* [Signing Android app][signing]
* [How to generate jks file][generate_jks]

[flutter_cd]: https://flutter.dev/docs/deployment/cd
[fastlane_recipe]: https://circleci.com/blog/adding-iac-security-scans-to-ci-pipelines/
[google_play_api_key_docs]: https://developers.google.com/android-publisher/getting_started
[signing]: https://developer.android.com/studio/publish/app-signing
[generate_jks]: https://medium.com/@psyanite/how-to-sign-and-release-your-flutter-app-ed5e9531c2ac

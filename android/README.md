# Laera. Android

## Release build

* Create `[project_root]/android/fastlane/keys` directory;
* Put there some files:
  * `google_play_api_key.json` - api key from `https://play.google.com/console/u/2/developers/<dev_id>/api-access`; [creating docs][google_play_api_key_docs]
  * `keystore.jks` - signing key; [how to generate][generate_jks]
  * `keystore.properties` - properties for `keystore.jks`; see link above
* Run `flutter build appbundle`

## Helpful links

* [Flutter cd][flutter_cd]
* [Fastlane recipe][fastlane_recipe]
* [Signing Android app][signing]

[google_play_api_key_docs]: https://developers.google.com/android-publisher/getting_started
[generate_jks]: https://medium.com/@psyanite/how-to-sign-and-release-your-flutter-app-ed5e9531c2ac
[fastlane_recipe]: https://circleci.com/blog/adding-iac-security-scans-to-ci-pipelines/
[flutter_cd]: https://flutter.dev/docs/deployment/cd
[signing]: https://developer.android.com/studio/publish/app-signing

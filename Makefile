.PHONY: generate
generate:
	flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: icon
icon:
	flutter pub run flutter_launcher_icons:main

.PHONY: build-dev
build-dev:
	(cd android && bundle exec fastlane build_apk_dev)

.PHONY: build
build:
	(cd android && bundle exec fastlane build_apk)

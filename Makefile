.PHONY: deps
deps:
	(cd android && bundle config path vendor/bundle)
	(cd android && bundle install --jobs 4 --retry 3)

.PHONY: generate
generate:
	flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: icon
icon:
	flutter pub run flutter_launcher_icons:main

.PHONY: build-aab
build-aab:
	(cd android && bundle exec fastlane build_aab)

.PHONY: build-apk
build-apk:
	(cd android && bundle exec fastlane build_apk)

.PHONY: build-apk-dev
build-apk-dev:
	(cd android && bundle exec fastlane build_apk_dev)

.PHONY: disable-analytics
disable-analytics:
	dart --disable-analytics
	flutter config --suppress-analytics --no-analytics

.PHONY: pre-ci
pre-ci: disable-analytics
	flutter --version

.PHONY: all
all: analyze test

.PHONY: deps
deps:
	flutter pub get

.PHONY: analyze
analyze:
	flutter analyze

.PHONY: test
test:
	flutter test --coverage

.PHONY: clean
clean:
	flutter clean

.PHONY: deps-ruby
deps-ruby:
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

.PHONY: ci-before
ci-before: disable-analytics
	flutter --version

.PHONY: ci
ci: deps analyze test

.PHONY: disable-analytics
disable-analytics:
	dart --disable-analytics
	flutter config --suppress-analytics --no-analytics

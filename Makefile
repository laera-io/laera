.PHONY: all
all: build-apk-dev lint test

# ========== dev ==========

.PHONY: lint
lint:
	flutter analyze

.PHONY: test
test:
	flutter test --coverage

.PHONY: clean
clean:
	flutter clean

# ========== generators ==========

.PHONY: generate
generate:
	flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: generate-icon
generate-icon:
	flutter pub run flutter_launcher_icons:main

# ========== build ========== 

.PHONY: build-aab
build-aab:
	(cd android && bundle exec fastlane build_aab)

.PHONY: build-apk
build-apk:
	(cd android && bundle exec fastlane build_apk)

.PHONY: build-apk-dev
build-apk-dev:
	(cd android && bundle exec fastlane build_apk_dev)

# ========== ci ==========

.PHONY: ci
ci: deps lint test

.PHONY: ci-before
ci-before: disable-analytics
	flutter --version

.PHONY: disable-analytics
disable-analytics:
	dart --disable-analytics
	flutter config --suppress-analytics --no-analytics

# ========== dependencies ==========

.PHONY: deps
deps:
	flutter pub get

.PHONY: deps-ruby
deps-ruby:
	(cd android && bundle config path vendor/bundle)
	(cd android && bundle install --jobs 4 --retry 3)

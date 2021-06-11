.PHONY: all
all: build-apk-dev lint test

# ========== dev ==========

.PHONY: lint
lint:
	@echo ========== $@ ==========
	@flutter analyze

.PHONY: test
test:
	@echo ========== $@ ==========
	@flutter test --coverage

.PHONY: clean
clean:
	@echo ========== $@ ==========
	@flutter clean

# ========== generators ==========

.PHONY: generate
generate:
	@echo ========== $@ ==========
	@flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: generate-icon
generate-icon:
	@echo ========== $@ ==========
	@flutter pub run flutter_launcher_icons:main

# ========== build ========== 

.PHONY: build-aab
build-aab:
	@echo ========== $@ ==========
	@(cd android && bundle exec fastlane build_aab)

.PHONY: build-apk
build-apk:
	@echo ========== $@ ==========
	@(cd android && bundle exec fastlane build_apk)

.PHONY: build-apk-dev
build-apk-dev:
	@echo ========== $@ ==========
	@(cd android && bundle exec fastlane build_apk_dev)

# ========== ci ==========

.PHONY: ci
ci: deps lint test

.PHONY: ci-before
ci-before: disable-analytics .version

.PHONY: disable-analytics
disable-analytics: .disable-dart-analytics .disable-flutter-analytics

.PHONY: .disable-dart-analytics
.disable-dart-analytics:
	@echo ========== $@ ==========
	@dart --disable-analytics

.PHONY: .disable-flutter-analytics
.disable-flutter-analytics:
	@echo ========== $@ ==========
	@flutter config --suppress-analytics --no-analytics

.PHONY: .version
.version:
	@echo ========== $@ ==========
	@flutter --version

# ========== dependencies ==========

.PHONY: deps
deps:
	@echo ========== $@ ==========
	@flutter pub get

.PHONY: deps-ruby
deps-ruby:
	@echo ========== $@ ==========
	@(cd android && bundle config path vendor/bundle)
	@(cd android && bundle install --jobs 4 --retry 3)

.PHONY: deps-ruby-update
deps-ruby-update:
	@echo ========== $@ ==========
	@(cd android && bundle update --jobs 4 --retry 3)

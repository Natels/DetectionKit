@PHONY: test
test:
	@echo "Running tests..."
	@xcodebuild test \
		-scheme DetectionKit \
		-destination "platform=iOS Simulator,name=iPhone 16 Pro,OS=latest"

	@xcodebuild test \
		-scheme DetectionKit \
		-destination "platform=macOS"

@PHONY: format
format:
	@swift format -ir --configuration swiftFormatConfig.json .
	
@PHONY: lint
lint:
	@swift format lint -r --configuration swiftFormatConfig.json .

@PHONY: precommit
precommit: test lint

workspace:
	./scripts/generate_xcworkspace.sh

output ?= .agents/interfaces

.PHONY: swiftinterface
swiftinterface:
	@./Scripts/generate-swiftinterfaces.sh --package-path . --output "$(output)" --configuration debug --build-arg --build-system --build-arg native

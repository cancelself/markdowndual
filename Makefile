APP_NAME := BikeMarked
BUNDLE_ID := com.local.bikemarked
INSTALL_DIR := ~/Applications
APP_BUNDLE := $(APP_NAME).app

.PHONY: build install uninstall clean lint

lint:
	@echo "Checking plist syntax..."
	plutil -lint Info.plist
	@echo "Checking applescript syntax..."
	osacompile -o /dev/null $(APP_NAME).applescript
	@echo "Lint passed."

build: lint
	osacompile -o $(APP_BUNDLE) $(APP_NAME).applescript
	plutil -replace CFBundleIdentifier -string $(BUNDLE_ID) $(APP_BUNDLE)/Contents/Info.plist
	plutil -replace CFBundleName -string $(APP_NAME) $(APP_BUNDLE)/Contents/Info.plist
	plutil -replace CFBundleDisplayName -string $(APP_NAME) $(APP_BUNDLE)/Contents/Info.plist
	/usr/libexec/PlistBuddy -c "Delete :CFBundleDocumentTypes" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null; true
	/usr/libexec/PlistBuddy -c "Merge Info.plist" $(APP_BUNDLE)/Contents/Info.plist
	@echo "Built $(APP_BUNDLE)"

install: build
	rm -rf $(INSTALL_DIR)/$(APP_BUNDLE)
	cp -R $(APP_BUNDLE) $(INSTALL_DIR)/
	/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f $(INSTALL_DIR)/$(APP_BUNDLE)
	duti -s $(BUNDLE_ID) net.daringfireball.markdown all
	@echo "Installed and registered as default .md handler."

uninstall:
	rm -rf $(INSTALL_DIR)/$(APP_BUNDLE)
	@echo "Removed $(APP_BUNDLE) from $(INSTALL_DIR)."

clean:
	rm -rf $(APP_BUNDLE)

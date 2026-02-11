APP_NAME := MarkdownDual
BUNDLE_ID := com.local.markdowndual
INSTALL_DIR := ~/Applications
APP_BUNDLE := $(APP_NAME).app
CONTENTS := $(APP_BUNDLE)/Contents
MACOS := $(CONTENTS)/MacOS

.PHONY: build install uninstall clean lint

lint:
	@echo "Checking plist syntax..."
	plutil -lint Info.plist
	@echo "Checking script syntax..."
	bash -n $(APP_NAME)
	@echo "Lint passed."

build: lint
	mkdir -p $(MACOS)
	cp Info.plist $(CONTENTS)/Info.plist
	cp $(APP_NAME) $(MACOS)/$(APP_NAME)
	chmod +x $(MACOS)/$(APP_NAME)
	@echo "Built $(APP_BUNDLE)"

install: build
	cp -R $(APP_BUNDLE) $(INSTALL_DIR)/
	/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f $(INSTALL_DIR)/$(APP_BUNDLE)
	duti -s $(BUNDLE_ID) net.daringfireball.markdown all
	@echo "Installed and registered as default .md handler."

uninstall:
	rm -rf $(INSTALL_DIR)/$(APP_BUNDLE)
	@echo "Removed $(APP_BUNDLE) from $(INSTALL_DIR)."

clean:
	rm -rf $(APP_BUNDLE)

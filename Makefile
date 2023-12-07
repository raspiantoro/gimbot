TARGET_DIR = bin

run: build
	@./$(TARGET_DIR)/gimbot $(ROM)

build:
	@[ -d $(TARGET_DIR) ] || mkdir -p $(TARGET_DIR)
	@odin build . --out=$(TARGET_DIR)/gimbot

clean:
	@rm -rf ./$(TARGET_DIR)

test: test-cpu test-cartridge

test-cpu:
	@[ -d $(TARGET_DIR)/test ] || mkdir -p $(TARGET_DIR)/test
	@odin test tests/cpu  -out=$(TARGET_DIR)/test/gimbot_test

test-cartridge:
	@[ -d $(TARGET_DIR)/test ] || mkdir -p $(TARGET_DIR)/test
	@odin test tests/cartridge  -out=$(TARGET_DIR)/test/gimbot_test
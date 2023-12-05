TARGET_DIR = bin

run: build
	@./$(TARGET_DIR)/gimbot

build:
	@[ -d $(TARGET_DIR) ] || mkdir -p $(TARGET_DIR)
	@odin build . --out=$(TARGET_DIR)/gimbot

clean:
	@rm -rf ./$(TARGET_DIR)

test:
	@[ -d $(TARGET_DIR)/test ] || mkdir -p $(TARGET_DIR)/test
	@odin test tests/*  -out=$(TARGET_DIR)/test/gimbot_test
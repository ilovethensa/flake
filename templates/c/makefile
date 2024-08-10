# Variables
CXX = clang++
CXXFLAGS = -Iinclude -Wall -Wextra -Werror -std=c++23
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build
TARGET = $(BUILD_DIR)/clol

# Find all .cpp and .h files in src and include directories
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
HDRS = $(wildcard $(INC_DIR)/*.h)

# Create object files list by replacing .cpp with .o and src/ with build/
OBJS = $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))

# Default target
all: $(TARGET)

# Rule to create the target binary
$(TARGET): $(OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(OBJS) -o $@

# Rule to compile .cpp files into .o files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Rule to format all .cpp and .h files
format:
	clang-format -i $(SRCS) $(HDRS)

# Rule to run clang-tidy on all .cpp files
tidy:
	for file in $(SRCS); do \
		echo "Running clang-tidy on $$file"; \
		clang-tidy --checks=* $$file -- $(CXXFLAGS); \
	done

# Clean target to remove compiled files
clean:
	rm -rf $(BUILD_DIR)

# Rule to run the binary
run: all
	./$(TARGET)

# PHONY targets
.PHONY: all clean format tidy check

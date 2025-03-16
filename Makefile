CC = gcc
CFLAGS = -MMD -Wall -Wextra -Wpedantic -Werror -std=c11
CFLAGS_DEBUG = -g3 -fsanitize=address -fsanitize=leak -fsanitize=undefined
CFLAGS_RELEASE = -O3 -DNDEBUG

TARGET = playground
SRC = $(filter-out $(TEST_SRC), $(wildcard *.c))
OBJ = $(SRC:.c=.o)

# foo.c has unit tests in foo_test.c
TEST_TARGET = test_runner
TEST_SRC = $(wildcard *_test.c)
TEST_OBJ = $(TEST_SRC:.c=.o)
TEST_TARGET_SRC = $(TEST_SRC:_test.c=.c)
TEST_TARGET_OBJ = $(TEST_TARGET_SRC:.c=.o)

DEP = $(OBJ:.o=.d) $(TEST_OBJ:.o=.d) $(TEST_TARGET_OBJ:.o=.d)

-include $(DEP)

all: debug

debug: CFLAGS += $(CFLAGS_DEBUG)
debug: $(TARGET)

release: CFLAGS += $(CFLAGS_RELEASE)
release: $(TARGET)

run: debug
	./$(TARGET)

test: CFLAGS += $(CFLAGS_DEBUG)
test: $(TEST_TARGET)
	./$(TEST_TARGET)

clean:
	rm -f $(TARGET) $(TEST_TARGET) *.o *.d

.PHONY: all debug release run test clean

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

$(TEST_TARGET): $(TEST_OBJ) $(TEST_TARGET_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ -lcriterion

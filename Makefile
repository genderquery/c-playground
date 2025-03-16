CC = gcc
CFLAGS = -Wall -Wextra -Wpedantic -Werror -std=c11

TARGET = playground
SRC = $(filter-out $(TEST_SRC), $(wildcard *.c))
OBJ = $(SRC:.c=.o)

# Build unit tests foo_test.c for foo.c
TEST_TARGET = test_runner
TEST_SRC = $(wildcard *_test.c)
TEST_OBJ = $(TEST_SRC:.c=.o)
TEST_TARGET_SRC = $(TEST_SRC:_test.c=.c)
TEST_TARGET_OBJ = $(TEST_TARGET_SRC:.c=.o)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

$(TEST_TARGET): $(TEST_OBJ) $(TEST_TARGET_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ -lcriterion

all: $(TARGET)

test: $(TEST_TARGET)
	./$(TEST_TARGET)

clean:
	rm -f $(OBJ) $(TARGET) $(TEST_OBJ) $(TEST_TARGET_OBJ) $(TEST_TARGET)

.PHONY: all test clean

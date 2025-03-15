CC = gcc
CFLAGS = -Wall -Wextra -Wpedantic -Werror -std=c11
SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
EXEC = playground

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(EXEC)

.PHONY: all clean

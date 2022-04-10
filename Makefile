CC = gcc
CFLAGS = -Wall -O3 -g
CFLAGS += -Ilib/glad/include -Ilib/glfw/include
LDFLAGS = lib/glad/src/glad.o lib/glfw/src/libglfw3.a -lm

SRC = $(wildcard src/*.c)
OBJ = $(SRC:.c=.o)
BIN = bin

.PHONY: all clean

all: libs game dirs

libs:
	cd lib/glad && $(CC) -o src/glad.o -Iinclude -c src/glad.c
	cd lib/glfw && cmake . && make

dirs:
	mkdir -p $(BIN)

game: $(OBJ)
	$(CC) -o $(BIN)/fluyd $^ $(LDFLAGS)

%.o: %.c 
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -rf $(BIN) $(OBJ)
PROCESSOR := $(shell uname -p)
CC = gcc
# Using -Ofast instead of -O3 might result in faster code,
# but is supported only by newer GCC versions
CFLAGS = -lm -pthread -O3 -W -Wall -Wextra -funroll-loops -Wno-unused-result
ifeq ($(PROCESSOR),x86_64)
  CFLAGS += -march=native
endif
ifeq ($(ASAN),1)
  CFLAGS += -fsanitize=address,undefined
endif

all: word2vec word2phrase distance word-analogy compute-accuracy

word2vec : word2vec.c
	$(CC) word2vec.c -o word2vec $(CFLAGS)
word2phrase : word2phrase.c
	$(CC) word2phrase.c -o word2phrase $(CFLAGS)
distance : distance.c
	$(CC) distance.c -o distance $(CFLAGS)
word-analogy : word-analogy.c
	$(CC) word-analogy.c -o word-analogy $(CFLAGS)
compute-accuracy : compute-accuracy.c
	$(CC) compute-accuracy.c -o compute-accuracy $(CFLAGS)

check:
	for d in demo*.sh; do echo $$d; time ./$$d; done
clean:
	rm -rf word2vec word2phrase distance word-analogy compute-accuracy

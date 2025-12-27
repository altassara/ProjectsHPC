CC     = mpicc
CFLAGS =
RM     = rm -f

all: ghost ghost_angles

ghost: ghost.c
	$(CC) $(CFLAGS) $^ -o $@

ghost_angles: ghost_angles.c
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: clean all
clean:
	$(RM) ghost ghost_angles
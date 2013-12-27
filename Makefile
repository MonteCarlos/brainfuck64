C_SRCS		= $(wildcard *.c)
ASM_SRCS	= $(wlidcard *.s)
OBJS		= $(patsubst %.c, %.o, $(C_SRCS)) $(patsubst %.s, %.o, $(ASM_SRC))
PRG		= bf64.prg
DISK		= bf64.d64
SAMPLES		= hello helloc
SAMPLE_BFS	= $(patsubst %, samples/%.bf, $(SAMPLES))

all: $(DISK)

bf64.d64: $(PRG) $(SAMPLE_BFS)
	c1541 -format "brainfuck64",8 d64 $@ -write $(PRG) $(basename $(notdir $(PRG))) \
		$(foreach BF, $(SAMPLE_BFS), -write $(BF) $(notdir $(BF)))

clean:
	rm -f $(OBJS)  $(PRG)

%.o: %.c
	cl65 -t c64 -c $< -o $@

%.o: %.s
	cl65 -t c64 -c $< -o $@

%.prg: $(OBJS)
	cl65 -t c64 $^ -o $@

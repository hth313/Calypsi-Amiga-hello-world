VPATH = src

CORE = 68000
COMMON_OPTIONS = --core=$(CORE) --target=Amiga --debug
CFLAGS = $(COMMON_OPTIONS)

# Common source files
ASM_SRCS =
C_SRCS = main.c

MODEL = --code-model=large --data-model=large

# Object files
OBJS = $(ASM_SRCS:%.s=obj/%.o) $(C_SRCS:%.c=obj/%.o)
OBJS_DEBUG = $(ASM_SRCS:%.s=obj/%-debug.o) $(C_SRCS:%.c=obj/%-debug.o)

obj/%.o: %.s
	as68k $(COMMON_OPTIONS) $(MODEL) --debug --list-file=$(@:%.o=%.lst) -o $@ $<

obj/%.o: %.c
	cc68k $(CFLAGS) $(MODEL) --list-file=$(@:%.o=%.lst) -o $@ $<

hello.elf:  $(OBJS)
	ln68k -o $@ $^ --target=amiga --output-format=Hunk --list-file=hello.lst --cross-reference --rtattr printf=reduced --rtattr cstartup=amiga --stack-size=5000 --semi-hosted

clean:
	-rm $(OBJS) $(OBJS:%.o=%.lst) $(OBJS_DEBUG) $(OBJS_DEBUG:%.o=%.lst)
	-rm hello.elf hello.hunk hello.lst

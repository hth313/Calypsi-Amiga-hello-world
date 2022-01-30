VPATH = src

CORE = 68000
COMMON_OPTIONS = --core=$(CORE) --target=Amiga --debug
CFLAGS = $(COMMON_OPTIONS) -I /home/hth/Documents/Amiga/NDK3.2/Include_H --fd /home/hth/Documents/Amiga/NDK3.2/FD

AMIGA = module/Calypsi-Amiga

# Common source files
ASM_SRCS =
C_SRCS = main.c

MODEL = --code-model=large --data-model=large
LIB_MODEL = lc-ld

AMIGA_LIB = $(AMIGA)/Amiga-68000-$(LIB_MODEL).a
AMIGA_LINKER_RULES = $(AMIGA)/linker-files/Amiga.scm

# Object files
OBJS = $(ASM_SRCS:%.s=obj/%.o) $(C_SRCS:%.c=obj/%.o)
OBJS_DEBUG = $(ASM_SRCS:%.s=obj/%-debug.o) $(C_SRCS:%.c=obj/%-debug.o)

obj/%.o: %.s
	as68k $(COMMON_OPTIONS) $(MODEL) --debug --list-file=$(@:%.o=%.lst) -o $@ $<

obj/%.o: %.c
	cc68k $(CFLAGS) $(MODEL) --list-file=$(@:%.o=%.lst) -o $@ $<

hello.hunk:  $(OBJS) $(AMIGA_LIB)
	ln68k -o $@ $^ $(AMIGA_LINKER_RULES) clib-$(CORE)-$(LIB_MODEL).a --output-format=Hunk --list-file=hello-Amiga.lst --cross-reference --rtattr printf=reduced --rtattr cstartup=amiga --stack-size=5000

$(AMIGA_LIB):
	(cd $(AMIGA) ; make all)

clean:
	-rm $(OBJS) $(OBJS:%.o=%.lst) $(OBJS_DEBUG) $(OBJS_DEBUG:%.o=%.lst) $(AMIGA_LIB)
	-rm hello.elf hello.hunk hello-debug.lst hello-Amiga.lst
	-(cd $(AMIGA) ; make clean)

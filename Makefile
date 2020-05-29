
BASEDIR = $(shell pwd)

# Compiler and linker options.
CC = gcc
TARGET_BIN = data_splitter
INCLUDE_DIR = include
SOURCES_DIR = src/data_splitter
ROOT_DEPDIR = .deps

COMPILER_FLAGS = -I${INCLUDE_DIR} -fasynchronous-unwind-tables -Ofast

SOURCES = $(shell find ${SOURCES_DIR} -name '*.c')
OBJECTS = $(SOURCES:%=%.o)
DEPFILES = $(SOURCES:%=${ROOT_DEPDIR}/%.d)
DEPFLAGS = -MT $@ -MMD -MP -MF ${ROOT_DEPDIR}/$*.d
DIR_L = $(shell find ${SOURCES_DIR} -type d)
SOURCES_DEPDIR = $(DIR_L:%=${ROOT_DEPDIR}/%)


all: ${TARGET_BIN}

${ROOT_DEPDIR}:
	mkdir -pv $@

${SOURCES_DEPDIR}: | ${ROOT_DEPDIR}
	mkdir -pv $@

${OBJECTS}: | ${SOURCES_DEPDIR}
	${CC} ${DEPFLAGS} ${COMPILER_FLAGS} ${@:%.o=%} -o $@

${TARGET_BIN}: ${OBJECTS}
	${CC} ${COMPILER_FLAGS} ${OBJECTS} -o ${TARGET_BIN}

-include ${DEPFILES}


clean:
	rm -rfv ${OBJECTS} ${TARGET_BIN}
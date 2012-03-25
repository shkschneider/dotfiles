#
# Makefile
#

#	Variables

CC	= gcc

NAME	= my

CFLAGS	= -I.
CFLAGS	:= -W -Wall -Wstrict-prototypes -pedantic -ansi
CFLAGS	:= -funroll-loops -O3

LDFLAGS	= -lc

SRC	= $(shell find . -type f -name "*.c")
SRC	:= $(subst ./,,$(SRC))

OBJ	= $(SRC:%.c=%.o)

RM	= rm -f

#	Rules

$(NAME)	: $(OBJ)
	$(CC) -o $(NAME) $(OBJ) $(LDFLAGS)

all	: $(NAME)

.c.o	:
	$(CC) -c $< -o $@ $(CFLAGS)

clean	:
	$(RM) $(OBJ)
	$(RM) $(shell find . -type f -name "*~" -o -name "#*#")

fclean	: clean
	$(RM) $(NAME)

re	: fclean all

.PHONY	: all clean fclean re

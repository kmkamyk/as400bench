/* Tworzenie obiektu o wielkości 10 GB w bibliotece */

/* Definicja parametrów */
DCL        VAR(&OBJLIB) TYPE(*CHAR) LEN(10) VALUE('NAZWA_BIBLIOTEKI')
DCL        VAR(&OBJNAME) TYPE(*CHAR) LEN(10) VALUE('NAZWA_OBIEKTU')
DCL        VAR(&OBJSIZE) TYPE(*DEC) LEN(15 0) VALUE(10000000000000) /* 10 GB */

/* Tworzenie obiektu */
CRTOBJ     OBJ(&OBJLIB/&OBJNAME) OBJTYPE(*FILE) SIZE(&OBJSIZE)

/* Wyświetlanie informacji o utworzonym obiekcie */
DSPOBJD    OBJ(&OBJLIB/&OBJNAME) OBJTYPE(*FILE)

/* Prosty benchmark dysków w języku CL dla IBM i */

/* Deklaracja zmiennych */
DCL VAR(&SIZE) TYPE(*DEC) LEN(10 0) VALUE(1048576) /* Rozmiar bufora - 1 MB */
DCL VAR(&ITER) TYPE(*DEC) LEN(10 0) VALUE(100) /* Liczba iteracji */
DCL VAR(&I) TYPE(*DEC) LEN(10 0) /* Licznik pętli */
DCL VAR(&START) TYPE(*DEC) LEN(15 5) /* Czas rozpoczęcia pomiaru */
DCL VAR(&END) TYPE(*DEC) LEN(15 5) /* Czas zakończenia pomiaru */
DCL VAR(&ELAPSED) TYPE(*DEC) LEN(15 5) /* Czas trwania pomiaru */
DCL VAR(&FILE) TYPE(*CHAR) LEN(10) /* Nazwa pliku */
DCL VAR(&LIB) TYPE(*CHAR) LEN(10) /* Nazwa biblioteki */

/* Ustawienie nazwy pliku i biblioteki */
CHGVAR VAR(&FILE) VALUE('MYFILE')
CHGVAR VAR(&LIB) VALUE('MYLIB')

/* Pomiar czasu odczytu */
CHGVAR VAR(&START) VALUE(%SST(%CHAR(&TIMESTAMP)) 9 6 + %SST(%CHAR(&TIMESTAMP)) 15 3 / 1000)
DSPFIL FILE(&LIB/&FILE) /* Odczytanie pliku */
CHGVAR VAR(&END) VALUE(%SST(%CHAR(&TIMESTAMP)) 9 6 + %SST(%CHAR(&TIMESTAMP)) 15 3 / 1000)
CHGVAR VAR(&ELAPSED) VALUE(&END - &START)
SNDPGMMSG MSG('Czas odczytu: ' *CAT %CHAR(&ELAPSED) *CAT ' sekund.')

/* Pomiar czasu zapisu */
CHGVAR VAR(&START) VALUE(%SST(%CHAR(&TIMESTAMP)) 9 6 + %SST(%CHAR(&TIMESTAMP)) 15 3 / 1000)
CRTDUPOBJ OBJ(&LIB/&FILE) FROMLIB(&LIB) TOLIB(&LIB) NEWOBJ(&FILE) /* Zapisanie pliku */
CLRPFM FILE(&LIB/&FILE) /* Wyczyszczenie pliku */
CHGVAR VAR(&END) VALUE(%SST(%CHAR(&TIMESTAMP)) 9 6 + %SST(%CHAR(&TIMESTAMP)) 15 3 / 1000)
CHGVAR VAR(&ELAPSED) VALUE(&END - &START)
SNDPGMMSG MSG('Czas zapisu: ' *CAT %CHAR(&ELAPSED) *CAT ' sekund.')

/* Pomiar czasu odczytu sekwencyjnego */
CHGVAR VAR(&START) VALUE(%SST(%CHAR(&TIMESTAMP)) 9 6 + %SST(%CHAR(&TIMESTAMP)) 15 3 / 1000)
OVRDBF FILE(&LIB/&FILE) SEQONLY(*YES) /* Ustawienie trybu odczytu sekwencyjnego */
DCLF FILE(&LIB/&FILE) /* Deklaracja pliku */
FOR (&I 1 TO &ITER) DO /* Pętla odczy

/* Prosty benchmark testujący dyski */

/* Definicja parametrów */
DCL        VAR(&OBJLIB) TYPE(*CHAR) LEN(10) VALUE('NAZWA_BIBLIOTEKI')
DCL        VAR(&OBJNAME) TYPE(*CHAR) LEN(10) VALUE('NAZWA_OBIEKTU')
DCL        VAR(&RECORDS) TYPE(*DEC) LEN(15 0) VALUE(10000) /* Liczba rekordów do zapisu i odczytu */
DCL        VAR(&RECORDSIZE) TYPE(*DEC) LEN(10 0) VALUE(1024) /* Rozmiar pojedynczego rekordu */

/* Tworzenie pliku */
CRTPF      FILE(&OBJLIB/&OBJNAME) RCDLEN(&RECORDSIZE)

/* Zapis rekordów */
DOWHILE   COND(&RECORDS > 0)
  ADDNBR    NBR(1) TOVAR(&RECORDS)
  ADDPFM    FILE(&OBJLIB/&OBJNAME) MBR(*FIRST) +
             DATA('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')
ENDDO

/* Odczyt rekordów */
DOWHILE   COND(&RECORDS > 0)
  RCVF      FILE(&OBJLIB/&OBJNAME) MBR(*FIRST) /* Odczyt jednego rekordu */
  MONMSG    MSGID(CPF0864) EXEC(DO) /* Obsługa końca pliku */
    CHGVAR    VAR(&RECORDS) VALUE(0)
  ENDDO
  ADDNBR    NBR(1) TOVAR(&RECORDS)
ENDDO

/* Usunięcie pliku */
DLTF       FILE(&OBJLIB/&OBJNAME)

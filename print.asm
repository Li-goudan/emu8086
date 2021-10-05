DATA SEGMENT
    STR DB 'I like computer very much.'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX
        LEA BX,STR
        MOV CX,26
LPP:
        MOV AH,2
        MOV DL,[BX]
        INC BX
        INT 21H
        LOOP LPP
        MOV AH,4CH
        INT 21H
CODE ENDS
     END START  
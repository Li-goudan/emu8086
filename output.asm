DATA SEGMENT
    STR DB 'My computer works well.',0DH,0AH,'$'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX
        LEA BX,STR
        MOV AH,09H    ;调用9号功能
        INT 21H
        MOV AH,4CH    ;返回DOS
        INT 21H
CODE ENDS
     END START  
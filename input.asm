DATA SEGMENT
    BUFSIZE DB 30      ;最多可输入30个字符
    ACTLEN DB 0        ;实际输入字符数
    STR DB 30 DUP(0)   ;实际输入的字符从此开始存放
DATA ENDS 
;
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX
        LEA DX,BUFSIZE        ;输入缓冲区起始偏移地址送DX
        MOV AH,0AH            ;调用0A号功能
        INT 21H               ;输入字符串并放入缓冲区
        XOR CX,CX
        MOV CL,ACTLEN         ;获取输入字符串个数
        LEA DX,STR            ;输入的字符串起始地址送DX
        MOV BX,DX             ;字符串首地址送BX
        ADD BX,CX             ;得到字符串尾地址
        MOV BYTE PTR[BX],'$'  ;在字符串尾插入'$'
        MOV AH,09H            ;调用9号功能
        INT 21H               
        MOV AH,4CH            ;调用返回DOS功能
        INT 21H               
CODE ENDS
     END START  
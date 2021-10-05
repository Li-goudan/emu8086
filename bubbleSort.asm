DATA   SEGMENT                  ;数据段
    ARRAY DB 41H,70H,03H,53H,88H,16H,8EH,3FH
    MESS1 DB 'INTPUT THE NUMBER YOU WHAT INSERT:',0DH,0AH,'$';请输入数字
    MESS3 DB 'EEROR',0DH,0AH,'$';错误提示
    MESS4 DB 'H,','$'           ;H跟逗号
    MESS5 DB 0DH,0AH,'RESULT:',0DH,0AH,'$';结果提示
    LEN  EQU 9                 ;输入的数字个数
    FLAG  DB 1                  ;标志输出是否结束
    CHANGE DB 0                 ;标志位，用于结束冒泡循环
DATA   ENDS



CODE   SEGMENT                  ;代码段
       ASSUME CS:CODE , DS:DATA ,  ES:DATA , SS:STACK   

START:  
                MOV AX, DATA
                MOV DS, AX         ;   设置数据段

 
     
;   程序的中间部分
                MOV AH,09H
                LEA DX,MESS1;输入提示
                INT 21H                 
                MOV SI,0
                LEA BX,ARRAY
INPUT1:                
                XOR DL,DL              
INPUT:
                MOV AH,01H
                INT 21H
                CMP AL,48H
                JE ENTER;等于H，说明结束一个二位数的输入                            
                CMP AL,30H;与0比较
                JB ERROR;小于0，错误                
                CMP AL,39H;与9比较
                JBE GET1;在0-9之间
                CMP AL,41H
                JB ERROR;错误
                CMP AL,46H
                JBE GET2;在A-F之间
                JMP ERROR;错误
GET1:;在0-9之间，减去30H
                SUB AL,30H
                JMP GET
GET2:;在A-F之间，减去37H
                SUB AL,37H                
                JMP GET
GET:;将DL左移4位用于存储新输入的位（本质跟10进制一样）
                MOV CL,4
                SHL DL,CL
                ;XOR AH,AH;消除高位的影响
                ADD DL,AL
                JMP INPUT;继续输入                            
ENTER:    
                MOV [BX+8],DL;将二位数存入当前指针所指的位置    
                ;清除影响                                
                XOR DX,DX
                XOR SI,SI
                XOR AL,AL                
                JMP SORT
ERROR:;错误提示    
                MOV AH,09H
                LEA DX,MESS3
                INT 21H                 
                JMP EXIT
;排序                
SORT:   
                MOV SI, OFFSET ARRAY                                 
                MOV CX, LEN-1                                 
                MOV CHANGE, 0                                      
GOON:   
                MOV AL,[SI]      
                INC SI                                  
                CMP AL,[SI]                                   
                JBE NEXT      
                MOV CHANGE, 1                            
                MOV DL,[SI]
                MOV [SI],AL
                MOV [SI-1],DL 
NEXT:        
                LOOP GOON
                CMP CHANGE, 0            
                JNE SORT
                ;输出RESULT提示   
                MOV AH,09H
                LEA DX,MESS5
                INT 21H
                XOR DX,DX
;输出排序结果             
PRINTHEAD:                
                INC FLAG;该标记用于判断是否输出完毕
PRINT:                          
                MOV AL,[BX]                
                MOV CL,4
                PUSH AX                
                SHR AL,CL
                OR AL,30H
                CMP AL,39H
                JBE DISPLAY1
                ADD AL,7
DISPLAY1:    
                MOV DL,AL
                MOV AH,02H
                INT 21H 
                POP AX
                AND AL,0FH
                OR AL,30H
                CMP AL,39H
                JBE DISPLAY2
                ADD AL,7
DISPLAY2:
                MOV DL,AL
                MOV AH,02H
                INT 21H  
                ;打印H，字样
                MOV AH,09H
                LEA DX,MESS4
                INT 21H
                XOR DX,DX                                
                INC BX
                ;INC BX        
                ;判断是否结束输出        
                CMP FLAG,LEN
                JBE PRINTHEAD                                                         
EXIT:                                             
        MOV   AH,4CH                                   
        INT   21H                                                                                        
CODE    ENDS                                          
        END  START
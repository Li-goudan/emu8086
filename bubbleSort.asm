DATA   SEGMENT                  ;���ݶ�
    ARRAY DB 41H,70H,03H,53H,88H,16H,8EH,3FH
    MESS1 DB 'INTPUT THE NUMBER YOU WHAT INSERT:',0DH,0AH,'$';����������
    MESS3 DB 'EEROR',0DH,0AH,'$';������ʾ
    MESS4 DB 'H,','$'           ;H������
    MESS5 DB 0DH,0AH,'RESULT:',0DH,0AH,'$';�����ʾ
    LEN  EQU 9                 ;��������ָ���
    FLAG  DB 1                  ;��־����Ƿ����
    CHANGE DB 0                 ;��־λ�����ڽ���ð��ѭ��
DATA   ENDS



CODE   SEGMENT                  ;�����
       ASSUME CS:CODE , DS:DATA ,  ES:DATA , SS:STACK   

START:  
                MOV AX, DATA
                MOV DS, AX         ;   �������ݶ�

 
     
;   ������м䲿��
                MOV AH,09H
                LEA DX,MESS1;������ʾ
                INT 21H                 
                MOV SI,0
                LEA BX,ARRAY
INPUT1:                
                XOR DL,DL              
INPUT:
                MOV AH,01H
                INT 21H
                CMP AL,48H
                JE ENTER;����H��˵������һ����λ��������                            
                CMP AL,30H;��0�Ƚ�
                JB ERROR;С��0������                
                CMP AL,39H;��9�Ƚ�
                JBE GET1;��0-9֮��
                CMP AL,41H
                JB ERROR;����
                CMP AL,46H
                JBE GET2;��A-F֮��
                JMP ERROR;����
GET1:;��0-9֮�䣬��ȥ30H
                SUB AL,30H
                JMP GET
GET2:;��A-F֮�䣬��ȥ37H
                SUB AL,37H                
                JMP GET
GET:;��DL����4λ���ڴ洢�������λ�����ʸ�10����һ����
                MOV CL,4
                SHL DL,CL
                ;XOR AH,AH;������λ��Ӱ��
                ADD DL,AL
                JMP INPUT;��������                            
ENTER:    
                MOV [BX+8],DL;����λ�����뵱ǰָ����ָ��λ��    
                ;���Ӱ��                                
                XOR DX,DX
                XOR SI,SI
                XOR AL,AL                
                JMP SORT
ERROR:;������ʾ    
                MOV AH,09H
                LEA DX,MESS3
                INT 21H                 
                JMP EXIT
;����                
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
                ;���RESULT��ʾ   
                MOV AH,09H
                LEA DX,MESS5
                INT 21H
                XOR DX,DX
;���������             
PRINTHEAD:                
                INC FLAG;�ñ�������ж��Ƿ�������
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
                ;��ӡH������
                MOV AH,09H
                LEA DX,MESS4
                INT 21H
                XOR DX,DX                                
                INC BX
                ;INC BX        
                ;�ж��Ƿ�������        
                CMP FLAG,LEN
                JBE PRINTHEAD                                                         
EXIT:                                             
        MOV   AH,4CH                                   
        INT   21H                                                                                        
CODE    ENDS                                          
        END  START
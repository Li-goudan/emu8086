DATA SEGMENT
    STRING1 DB 'Do you like this book ?',0DH,0AH,'$'
    STRING2 DB 0DH,0AH,'You may go to the next store.',0DH,0AH,'$'
    STRING3 DB 0DH,0AH,'I think you will buy it.',0DH,0AH,'$' 
DATA ENDS
;
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:  
	MOV AX,DATA
        	MOV DS,AX
        	LEA DX,STRING1     ;显示提问"Do you like this book ?"
        	MOV AH,09H	;调用9号字符串输出功能
        	INT 21H
KEY:    
	MOV AH,1    	;调用1号单字符输入功能
        	INT 21H
        	CMP AL,'Y'
        	LEA DX,STRING2
        	JE EXIT
        	CMP AL,'N'
        	LEA DX,STRING3
        	JE EXIT
        	JMP KEY
EXIT:   
	MOV AH,09H	;调用9号字符串输出功能
        	INT 21H
        	MOV AH,4CH	;返回DOS功能
        	INT 21H
CODE ENDS
    	END START
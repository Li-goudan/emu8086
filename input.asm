DATA SEGMENT
    BUFSIZE DB 30      ;��������30���ַ�
    ACTLEN DB 0        ;ʵ�������ַ���
    STR DB 30 DUP(0)   ;ʵ��������ַ��Ӵ˿�ʼ���
DATA ENDS 
;
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX
        LEA DX,BUFSIZE        ;���뻺������ʼƫ�Ƶ�ַ��DX
        MOV AH,0AH            ;����0A�Ź���
        INT 21H               ;�����ַ��������뻺����
        XOR CX,CX
        MOV CL,ACTLEN         ;��ȡ�����ַ�������
        LEA DX,STR            ;������ַ�����ʼ��ַ��DX
        MOV BX,DX             ;�ַ����׵�ַ��BX
        ADD BX,CX             ;�õ��ַ���β��ַ
        MOV BYTE PTR[BX],'$'  ;���ַ���β����'$'
        MOV AH,09H            ;����9�Ź���
        INT 21H               
        MOV AH,4CH            ;���÷���DOS����
        INT 21H               
CODE ENDS
     END START  
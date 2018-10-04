MODEL SMALL
.DATA
.STACK

MSG1 DB 'Ingrese primer numero$'
MSG2 DB 'Ingrese segundo numero$'
MSG3 DB 'num1 es mayor que num2$'
MSG4 DB 'num2 es mayor que num1$'
MSGE DB 'son iguales$'

num1 DB ?
num2 DB ?

.CODE
    programa:
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV DX, offset MSG1
    MOV AH, 09h
    INT 21h
    
    MOV AH, 1h ;lee el primer numero
    INT 21h
    
    XOR DX,DX
    SUB AL, 30h ;asigna AL al primer numero
    MOV DL, AL
    MOV num1, DL
    
    MOV DL, 10
    MOV AH, 02h
    INT 21h     ;segmento para crear una nueva linea
    MOV DL, 13
    MOV AH, 02h
    INT 21h
    
    MOV DX, offset MSG2
    MOV AH, 09h
    INT 21h
    
    MOV AH, 1h ; lee el segundo numero
    INT 21h
    
    XOR DX, DX
    SUB AL, 30h ;asigna el segundo numero a DL
    MOV DL, AL
    MOV num2, DL
    
    MOV DL, 10
    MOV AH,02h
    INT 21h     ;newline
    MOV DL, 13
    MOV AH,02h
    INT 21h
    
    XOR AX, AX
    XOR DX, DX
    
    MOV AL, num1
    MOV DL, num2
    CMP AL, DL  ; son iguales?
    JA mayor
    JB menor
    
    
    Igual:
    XOR AX,AX
    MOV DX, offset MSGE
    MOV AH, 09h
    INT 21h
    JMP exit
    
    mayor:
    XOR AX,AX
    MOV DX, offset MSG3
    MOV AH, 09h
    INT 21h
    JMP exit
    
    menor: 
    XOR AX, AX
    MOV DX, offset MSG4
    MOV AH, 09h
    INT 21h
    
    exit:
    MOV AH, 4Ch
    int 21h
    
    
    
    END programa


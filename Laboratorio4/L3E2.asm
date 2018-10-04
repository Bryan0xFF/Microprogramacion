MODEL SMALL
.DATA
.STACK

MSG1 DB 'Ingrese el primer numero$'
MSG2 DB 'Ingrese el segundo numero$'
MSG3 DB 'Multiplicacion$'
MSG4 DB 'Division$'
num1 DB ?
num2 DB ?
num1_sum DB ?

.CODE
    programa:
   
    MOV AX, @DATA
    MOV DS, AX
    MOV DX, offset MSG1
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h ;lee el primer caracter
    INT 21h
    
    SUB AL, 30h
    MOV num1,AL ;asigna el primer valor a num1
    
    MOV DL, 10
    MOV AH,02h
    INT 21h     ;newline
    MOV DL, 13
    MOV AH,02h
    INT 21h
    
    XOR DX,DX
    MOV DX, offset MSG2
    MOV AH, 09h
    INT 21h
    
        
    MOV AH, 01h  ;lee el segundo caracter
    INT 21h 
    
    SUB AL, 30h
    MOV num2, AL ;asigna AL al num2
    
    
    
    XOR AX, AX
    XOR BX, BX  ; limpiamos los 2 registros
   
    MOV AL, num1
    MOV BL, num2
    
    CMP AL, BL
    JGE op_num_1
    JMP op_num_2
    
    
    op_num_1:
    XOR CX, CX  ;limpia el counter
    MOV CL, BL  ;se asigna el menor al contador
    DEC CL
    JMP suma_iter
    
    op2_num_1:
    XOR DX,DX
    MOV DL, num1_sum
    ADD DL, 30h ;suma para mostrar el ascii
    MOV AH, 02h ;muestra el resultado de la multiplicacion 
    INT 21h
    MOV CL, BL  ;se reestablece el counter
    DEC CL
    MOV DH, AL  ;se mueve el resultado de la multiplicacion a la parte DH
    MOV AL, num1 ;se reestablece el operando AL
    XOR AH, AH  ;hace 0 el espacio AH
    JMP resta_iter ;se realiza la division
    
    suma_iter:
    ADD AL, AL
    MOV num1_sum, AL
    DEC CL
    CMP CL, 0
    JZ op2_num_1
    
    resta_iter:
    CMP AL, BL ;comprueba la resta de f(n+1)
    JL printNZero ;es negativo? se va a escribir cociente y residuo
    SUB AL, BL  ;aplica la operacion f(n+1) => f(n)
    CMP AL, 0   ;comprueba si es cero en f(n)
    JZ printZero ; es cero en f(n)? salte a escribir residuo
    INC AH      ;incrementa en 1 
    JMP resta_iter
    
    op_num_2:
    XOR CX,CX
    MOV CL, AL
    XCHG AL, BL ;cambiamos los valores para reutilizar codigo
    JMP suma_iter
    JMP resta_iter
    
    printNZero:
    MOV DL, AH ;mueve el cociente a DL
    MOV DH, AL ; mueve el residuo a DH
    ADD DL, 30h
    MOV AH, 02h
    INT 21h
    MOV DL, DH
    ADD DL, 30h
    MOV AH, 02h
    INT 21h
    JMP exit
    
    printZero:
    XOR DX,DX
    MOV DL, AH ; cociente a DL
    ADD DL, 30h
    MOV DH, 0 ; residuo a DH
    MOV AH, 02h
    INT 21h
    MOV DL, DH ; mueve el residuo a DL
    ADD DL, 30h
    MOV AH, 02h ;imprime DL
    INT 21h
    JMP exit
    
    exit:
    MOV AH, 4Ch
    INT 21h
    
    END programa
    
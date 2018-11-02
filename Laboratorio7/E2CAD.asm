.MODEL SMALL
.DATA
.STACK
CAD1 DB 100 DUP('$')
MSG1 DB 'INGRESE LA CADENA: $'
.CODE
    PROGRAMA:
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    CALL NEWLINE
    LEA SI, CAD1
    
    CADENA1:
    XOR AX,AX
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JE CONVERTIR_INTERMEDIO
    MOV CAD1[SI], AL
    INC SI
    JMP CADENA1
    
    CONVERTIR_INTERMEDIO:
    CALL NEWLINE
    LEA SI, CAD1
    JMP CONVERTIR
    
    CONVERTIR:
    XOR DX, DX
    XOR AX, AX
    MOV DL, CAD1[SI]
    SUB DL, 20H
    MOV AH, 02H
    INT 21H
    CMP DL, 04H
    JE EXIT
    INC SI
    JMP CONVERTIR
    
    NEWLINE PROC NEAR
    MOV DL, 10
    MOV AH, 02h
    INT 21h
    MOV DL, 13
    MOV AH, 02h
    INT 21H
    RET
    NEWLINE ENDP
    
    EXIT:
    MOV AH, 4CH
    INT 21H
    
    END PROGRAMA
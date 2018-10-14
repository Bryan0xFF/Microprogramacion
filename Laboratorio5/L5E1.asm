model small
.DATA

MSG1 db 'ingrese numero de 2 digitos$'
num1 db ?

.stack
.code
    programa:
    mov ax,@DATA
    mov ds,ax
    
    mov dx, offset MSG1 
    mov ah, 09h
    int 21h ;despliega el mensaje 
    
    mov ah, 01h ; lee el primer caracter
    int 21h
    sub al, 30h ;substrae el ascii
    
    mov ah, 10d  ; multiplica por 10 a AL por default
    mul ah
    mov  num1, al ;asigna a num1
    xor ax,ax
    
    mov ah, 01h
    int 21h ;lee el segundo numero
    sub al, 30h ;substrae el ascii del numero
    add num1, al ; se le suma el segundo numero
    
    xor cx,cx
    xor ax,ax
    xor dx,dx
    mov cl, num1
    
    base_8:
    inc al  ;este es el cociente
    sub num1, 8 ;substrae de num1 8
    cmp num1, 8 ;compara num1 contra 8
    jl invertir
    loop base_8
    
    invertir:
    mov dl, al
    mov dh, ah
    
    mov ah, 00h
    mov al, 02h
    int 10h
    
    add dl, 30h ;suma es ascii
    mov ah, 02h
    int 21h
    mov dl, num1
    add dl, 30h
    mov ah, 02h
    int 21h
    
    mov ah, 4ch
    int 21h
    END programa
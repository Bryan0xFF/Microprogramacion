model small
.stack
.data

MSG1 db 'ingrese numero de dos digitos$'
num db ?

.code
    program:
    
    mov ax, @data
    mov ds, ax
    
    mov dx, offset MSG1
    mov ah, 09h
    int 21h
    
    xor ax,ax
    mov ah, 01h
    int 21h
    
    sub al, 30h
    mov bl, 10h ;multiplica el primer numero para obtener decenas
    mul bl
    
    mov num, al
    mov ah, 01h
    int 21h
    sub al, 30h
    add num, ah
    
    xor ax,ax
    xor dx,dx
    xor cx,cx
    xor bx,bx
    
    mov al, num
    mov dl, 02h
    div dl  ;los factores no sobrepasan n/2, por lo cual hago la div por 2
    mov cl, al ; muevo al contador
    
    factores:
    xor ax,ax
    mov al, num ;muevo el numero a la parte baja de al
    cmp cl,0
    jz exit ;salta a la salida debido a que cx es 0, por lo cual daria una div por 0
    div cl
    cmp ah,0 ;si el residuo es cero, entonces es factor
    jz imprimir_factor
    loop factores
    
    imprimir_factor:
    mov dx, ax
    add dx, 30h
    mov ah, 02h
    int 21h
    jmp factores
    
    exit:
    mov ah, 00h
    mov al, 02h ;interrupcion de video limpiar pantalla
    int 10h
    mov ah, 4ch
    int 21h
    end program
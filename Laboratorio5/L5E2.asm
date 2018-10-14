model small
.stack
.data

MSG1 db 'presione cualquier tecla para escribir, presione enter para limpiar$'
msg2 db 'x$'
.code
    programa:
    
    
    
    ;ingeniera, yo fui el que le hablo el sabado sobre el loop, en el primero si
    ;me funciono, pero en este no, tal vez llenaba de basura cx, intente usar loop
    ;pero no,primero me enoje, entonces mejor lo deje con jumps
    
    
    
    mov ax, @data
    mov ds, ax
    
    mov dx, offset MSG1
    mov ah, 09h
    int 21h
    
    escribir:
    mov ah, 01h
    int 21h
    cmp al, 0Dh ;compara si el codigo ingresado es enter
    je limpiar_pantalla
    
    mov dl, 08h
    mov ah, 02h ;imprime un backspace
    int 21h
    mov ah, 02h         
    mov dl, 20h ;setea en la posicion del caracter un space  
    int 21h             
    mov dl, 08h ;hace un backspace para regresar a la posicion ya con una cadena vacia
    int 21h      
    
    mov dx, offset msg2 ;escribe x
    mov ah, 09h
    int 21h
    
    jmp escribir
   
    limpiar_pantalla:
    mov ah, 00h
    mov al, 02h
    int 10h
     
    
    mov ah, 4ch
    int 21h
    end programa
.model small
.stack 100h


.data
include imgData\car.asm
    posX dw ?
    posY dw ?
    width dw ?
    height dw ?
    rowStop dw ?
    area dw ?
    
.code

include funcs.asm

main proc
    mov ax, @data
    mov ds, ax
    mov ah, 0h
    mov al, 13h
    int 10h
    
car:
    lea si, carData
    mov posX, 150
    mov posY, 79
    mov width, 20
    mov height, 42
    call init
    call draw


main endp

end main

.model small
.stack 100h


.data
    include .\imgData\car.asm
    posX dw 150
    posY dw 140
    width dw ?
    height dw ?
    rowStop dw ?
    colStop dw ?
    
.code

include .\funcs.asm
include .\draw.asm

main proc
    mov ax, @data
    mov ds, ax
    mov ah, 0h
    mov al, 13h
    int 10h
    
    call background
    
gameLoop: 
    call car
    
    jmp gameLoop


main endp

end main

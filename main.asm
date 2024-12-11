.model small
.stack 100h


.data
    include .\imgData\car.asm
    posX dw ?
    posY dw ?
    width dw ?
    height dw ?
    rowStop dw ?
    colStop dw ?
    
.code

include .\preFuncs.asm
include .\funcs.asm

main proc
    mov ax, @data
    mov ds, ax
    mov ah, 0h
    mov al, 13h
    int 10h
    
    call background
   
    call car


main endp

end main

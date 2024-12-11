.model small
.stack 100h


.data
    include .\imgData\car.asm
    include .\imgData\hole.asm
    posX dw ?
    posY dw ?
    width dw ?
    height dw ?
    rowStop dw ?
    colStop dw ?
    carX dw 150
    carY dw 140
    holeX dw 100
    enemyY dw 20
    speed dw ?
    
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
    call hole
    call car
    
    jmp gameLoop


main endp

end main

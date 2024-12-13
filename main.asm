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
    speed dw ?
    randSize dw 2
    randVal dw ?
    randArr dw 100, 130
    randIdx dw 0
    randSeed dw 1234
    carX dw 150
    carY dw 140
    holeX dw ?
    enemyY dw ?
    clipVal dw 0
    ticks dw 500

    
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
    
    mov holeX, 100
    mov enemyY, -52
    
gameLoop: 
    call hole

    call car
    
    jmp gameLoop


main endp

end main

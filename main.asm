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
    randSize dw 3
    randVal dw ?
    randArr dw 100, 130, 160
    randIdx dw 0
    randSeed dw 1234
    carX dw 150
    carY dw 140
    holeX dw ?
    holeY dw -52
    coneX dw ?
    coneY dw ?

    
.code

include .\funcs.asm
include .\draw.asm

main proc
main:
    mov ax, @data
    mov ds, ax
    mov ah, 0h
    mov al, 13h
    int 10h
    
    call background
    
    call rand
    mov ax, randVal
    mov holeX, ax
    
gameLoop: 
    call hole

    call car
    
    jmp gameLoop


main endp

end main

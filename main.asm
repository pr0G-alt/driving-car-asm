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
    carX dw ?
    carY dw ?
    holeX dw ?
    holeY dw ?
    coneX dw ?
    coneY dw ?
    detect dw 0
    
.code

include .\funcs.asm
include .\draw.asm

main proc
    mov ax, @data
    mov ds, ax
    mov ah, 0h
    mov al, 13h
    int 10h
restart:
    
    call background

    mov carX, 150
    mov carY, 140
    mov detect, 0
    mov holeY, -52  
    
    call rand
    mov ax, randVal
    mov holeX, ax
    
gameLoop: 
    call hole

    call car
    
    cmp detect, 1
    jne gameLoop
    mov ah, 0h
    int 16h
    
    jmp restart


main endp

end main

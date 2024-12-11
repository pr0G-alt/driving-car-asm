.model small
.stack 100h


.data
    include .\imgData\bg.asm
    include .\imgData\car.asm
    posX dw ?
    posY dw ?
    width dw ?
    height dw ?
    rowStop dw ?
    colStop dw ?
    area dw ?
    
.code

include .\funcs.asm

main proc
    mov ax, @data
    mov ds, ax
    mov ah, 0h
    mov al, 13h
    int 10h
    
    call background
   
    mov posX, 150
    mov posY, 140
    
drawCar:
    lea si, carData
    mov width, 20
    mov height, 42
    call init
    call draw
    
getInput:
    mov ah, 1h
    int 16h
    jz getInput

    mov ah, 0h
    int 16h

    cmp ah, 1h
    je exitGame

    cmp ah, 48h
    je moveUp
    
    cmp ah, 50h
    je moveDown
    
    cmp ah, 4Bh
    je moveLeft
    
    cmp ah, 4Dh
    je moveRight

    jmp getInput

moveUp:
    cmp posY, 0
    jle getInput
    call clearDown
    sub posY, 2
    jmp drawCar

moveDown:
    cmp posY, 200-42
    jge getInput
    call clearUp
    add posY, 2
    jmp drawCar

moveLeft:
    cmp posX, 98
    jle getInput
    call clearRight
    sub posX, 2
    jmp drawCar

moveRight:
    cmp posX, 320-20-98
    jge getInput
    call clearLeft
    add posX, 2
    jmp drawCar

exitGame:
    mov ax, 4C00h
    int 21h
    

main endp

end main

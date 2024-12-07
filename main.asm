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
    area dw ?
    include .\imgData\bg.asm
    
.code

include .\funcs.asm

main proc
    mov ax, @data
    mov ds, ax
    mov ah, 0h
    mov al, 13h
    int 10h
    
    mov cx, 0
    mov dx, 0
    call background
   
    mov posX, 150
    mov posY, 79
    
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
    je getInput
    call clearDown
    dec posY
    jmp drawCar

moveDown:
    cmp posY, 200-42
    je getInput
    call clearUp
    inc posY
    jmp drawCar

moveLeft:
    cmp posX, 97
    je getInput
    call clearRight
    dec posX
    jmp drawCar

moveRight:
    cmp posX, 320-20-97
    je getInput
    call clearLeft
    inc posX
    jmp drawCar

exitGame:
    mov ax, 03h
    int 10h

    mov ax, 4C00h
    int 21h
    

main endp

end main

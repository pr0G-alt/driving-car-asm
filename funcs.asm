; background = draw background
; car = draw car


background proc
    mov cx, 0
    mov dx, 0
    
    mov ah, 0ch
    
    mov al, 2
drawBgLoop:
    int 10h
    inc cx
    cmp cx, 90
    jl drawBgLoop
    mov al, 15
    cmp cx, 95
    jl drawBgLoop
    mov al, 29
    cmp cx, 97
    jl drawBgLoop
    mov al, 23
    cmp cx, 320-97
    jl drawBgLoop
    mov al, 29
    cmp cx, 320-95
    jl drawBgLoop
    mov al, 15
    cmp cx, 320-90
    jl drawBgLoop
    mov al, 2
    cmp cx, 320
    jl drawBgLoop
    
    mov cx, 0
    inc dx
    cmp dx, 200
    jl drawBgLoop
    
    ret
background endp

car proc
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
car endp
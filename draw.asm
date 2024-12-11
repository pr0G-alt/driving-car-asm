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
drawCar:
    lea si, carData
    mov width, 20
    mov height, 42
    call init
    call draw
    
getInput:
    mov ah, 1h
    int 16h
    jz noInput

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

    jmp noInput

moveUp:
    cmp posY, 0
    jle noInput
    call clearDown
    sub posY, 2
    jmp drawCar

moveDown:
    cmp posY, 200-42
    jge noInput
    call clearUp
    add posY, 2
    jmp drawCar

moveLeft:
    cmp posX, 98
    jle noInput
    call clearRight
    sub posX, 2
    jmp drawCar

moveRight:
    cmp posX, 320-20-98
    jge noInput
    call clearLeft
    add posX, 2
    jmp drawCar
    
noInput:
    ret

exitGame:
    mov ax, 4C00h
    int 21h
car endp
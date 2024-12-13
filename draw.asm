; background = draw game background
; car = draw player's car
; hole = draw a hole


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
    mov ax, carX
    mov posX, ax
    mov ax, carY
    mov posY, ax
    mov width, 20
    mov height, 42
    mov speed, 4
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
    cmp carY, 0
    jle noInput
    call clearDown
    mov ax, speed
    sub carY, ax
    jmp drawCar

moveDown:
    cmp carY, 200-42
    jge noInput
    call clearUp
    mov ax, speed
    add carY, ax
    jmp drawCar

moveLeft:
    cmp carX, 98
    jle noInput
    call clearRight
    mov ax, speed
    sub carX, ax
    jmp drawCar

moveRight:
    cmp carX, 320-20-98
    jge noInput
    call clearLeft
    mov ax, speed
    add carX, ax
    jmp drawCar
    
noInput:
    ret

exitGame:
    mov ax, 4C00h
    int 21h
car endp

hole proc
wait_loop:
    dec ticks
    cmp ticks, 0
    jg holeSkip
holeDraw:
    cmp enemyY, 200
    je resetHole
    lea si, holeData
    mov ax, holeX
    mov posX, ax
    mov ax, enemyY
    mov posY, ax
    mov width, 90
    mov height, 53
    mov speed, 1
    
    call init
    call clip
    call draw
    
    call clearUp

    inc enemyY
holeSkip:
    ret
    
resetHole:
    call rand
    mov ax, randVal
    mov holeX, ax
    mov enemyY, -20
    jmp holeSkip

hole endp
    
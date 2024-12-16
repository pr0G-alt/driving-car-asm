; background = draw game background
; startMsg = draw start message to choose difficulty
; heart = draw heart for health
; printHealth = draw player's health on the heart
; car = draw player's car
; hole = draw a hole
; gameOver = draw GAME OVER message


background proc
    mov cx, 0 ; X axis starting point
    mov dx, 0 ; Y axis starting point
    
    mov ah, 0ch
    
    mov al, 2 ; green
drawBgLoop:
    int 10h
    inc cx
    cmp cx, 88 ; number of pixels for each color in a row
    jl drawBgLoop
    mov al, 15 ; white grey
    cmp cx, 93
    jl drawBgLoop
    mov al, 29 ; light grey
    cmp cx, 95
    jl drawBgLoop
    mov al, 23 ; dark grey
    cmp cx, 320-95
    jl drawBgLoop
    mov al, 29
    cmp cx, 320-93
    jl drawBgLoop
    mov al, 15
    cmp cx, 320-88
    jl drawBgLoop
    mov al, 2
    cmp cx, 320
    jl drawBgLoop
    
    ; start drawing the next row
    mov cx, 0
    inc dx
    cmp dx, 200
    jl drawBgLoop
    
    ret
background endp

startMsg proc
    mov ah, 2h
    mov dl, 9
    mov dh, 10
    int 10h
    mov ah, 9h
    lea dx, easyMsg
    int 21h
    
    mov ah, 2h
    mov dl, 9
    mov dh, 12
    int 10h
    mov ah, 9h
    lea dx, hardMsg
    int 21h
    
    mov ah, 2h
    mov dl, 9
    mov dh, 14
    int 10h
    mov ah, 9h
    lea dx, exitMsg
    int 21h
    
    ret
startMsg endp

heart proc
    lea si, heartData
    mov width, 18
    mov height, 15
    mov posX, 2
    mov posY, 4
    call init
    call draw

    ret
heart endp

printHealth proc
    mov ah, 2h
    mov dh, 1 ; starting line
    mov dl, 1 ; line starting character
    int 10h
    mov dl, health
    add dl, '0' ; convert number into ASCII
    mov ah, 2h
    int 21h
    ret
printHealth endp

car proc
drawCar:
    lea si, carData
    ; specify car data for initialization ;
    mov ax, carX
    mov posX, ax
    mov ax, carY
    mov posY, ax
    mov width, 20
    mov height, 42
    ; =================================== ;
    
    mov speed, 5
    
    call init
    call draw
    
    ; calculate horizonal & vertical middles ;
    mov ax, rowStop
    sub ax, 10
    mov carMidX, ax
    mov ax, colStop
    sub ax, 21
    mov carMidY, ax
    ; ====================================== ;
    
getInput:
    mov ah, 1h
    int 16h
    jz noInput

    mov ah, 0h
    int 16h

    cmp ah, 1h
    je exitGame

    cmp ah, 48h ; Up arrow
    je moveUp
    
    cmp ah, 50h ; Down arrow
    je moveDown
    
    cmp ah, 4Bh ; Left arrow
    je moveLeft
    
    cmp ah, 4Dh ; Right arrow
    je moveRight

    jmp noInput ; avoid stoping game loop

moveUp:
    cmp carY, 0 ; avoid moving out of the window
    jle noInput
    call clearDown
    
    ; update car position & draw ;
    mov ax, speed
    sub carY, ax
    jmp drawCar
    ; ========================== ;

moveDown:
    cmp carY, 200-42
    jge noInput
    call clearUp
    mov ax, speed
    add carY, ax
    jmp drawCar

moveLeft:
    cmp carX, 95  ; avoid moving out of the road
    jle noInput
    call clearRight
    mov ax, speed
    sub carX, ax
    jmp drawCar

moveRight:
    cmp carX, 320-20-95
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
holeDraw:
    cmp holeY, 200
    jge resetHole
    lea si, holeData
    mov ax, holeX
    mov posX, ax
    mov ax, holeY
    mov posY, ax
    mov width, 57
    mov height, 53
    mov ax, diff
    mov speed, ax
    
    call init
    call clip
    call draw
    
    mov ax, rowStop
    sub ax, 28
    mov holeMidX, ax
    mov ax, colStop
    sub ax, 26
    mov holeMidY, ax
    
    call clearUp

    mov ax, speed
    add holeY, ax
holeSkip:
    ret
    
resetHole:
    call rand
    mov ax, randVal
    mov holeX, ax
    mov holeY, -52
    jmp holeSkip

hole endp

gameOver proc
    mov ah, 2h
    mov dl, 15
    mov dh, 10
    int 10h
    mov ah, 9h
    lea dx, gameOverMsg
    int 21h
    
    mov ah, 2h
    mov dl, 7
    mov dh, 12
    int 10h
    mov ah, 9h
    lea dx, enterMsg
    int 21h
    
    mov ah, 2h
    mov dl, 7
    mov dh, 14
    int 10h
    mov ah, 9h
    lea dx, exitMsg
    int 21h

    ret
gameOver endp
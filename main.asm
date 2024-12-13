.model medium
.stack 1000h


.data
    include .\imgData\car.asm
    include .\imgData\hole.asm
    include .\imgData\heart.asm
    include .\imgData\gameOver.asm
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
    
    health db 5
    carMidX dw ?
    carMidY dw ?
    holeMidX dw ?
    holeMidY dw ?
    distX dw ?
    distY dw ?
    detect dw 0
    ticks dw 1000
    msg db 'Press any key to play$', 0
    
    
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
    mov ah, 02h
    mov bh, 0
    mov dh, 11
    mov dl, 10
    int 10h
    mov ah, 09h
    lea dx, msg
    int 21h
    
    mov ah, 0h
    int 16h
restart:
    call background
    
    call heart
    
    mov carX, 150
    mov carY, 140
    mov holeY, -52  
    
    call rand
    mov ax, randVal
    mov holeX, ax
       
    mov health, 5
    mov ah, 02h
    mov bh, 0
    mov dh, 1
    mov dl, 1
    int 10h
    mov dl, '5'
    mov ah, 02h
    int 21h
      
gameLoop:
    call hole

    call car
    
    mov ax, carMidX
    sub ax, holeMidX
    test ax, ax
    jns posDistX
    neg ax
posDistX:
    mov distX, ax
    
    mov ax, carMidY
    sub ax, holeMidY
    test ax, ax
    jns posDistY
    neg ax
    
posDistY:
    mov distY, ax
    
    cmp distX, 34
    jg detectSkip
    
    cmp distY, 30
    jg detectSkip
    
    mov detect, 1
    
    cmp distX, 24
    jg detectSkip
    
    cmp distY, 25
    jg detectSkip
    mov detect, 0
restartHelp:
    call gameOver
    mov ah, 0h
    int 16h
    jmp restart
    
help:
    jmp gameLoop
    
detectSkip:
    cmp detect, 1
    jne gameLoop
    
    cmp distY, 40
    jl gameLoop
    
    mov detect, 0
    dec health
    
    mov ah, 02h
    mov bh, 0
    mov dh, 1
    mov dl, 1
    int 10h

    mov dl, health
    add dl, '0'
    mov ah, 02h
    int 21h

    cmp health, 0
    jne help
    jmp restartHelp

main endp

end main

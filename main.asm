.model large
.stack 9000h


.data
    ; ========= IMAGEs DATA ========= ;
    include .\imgData\car.asm
    include .\imgData\hole.asm
    include .\imgData\heart.asm
    ; =============================== ;
    
    ; = Drawing data initialization = ;
    posX dw ?
    posY dw ?
    width dw ?
    height dw ?
    rowStop dw ?
    colStop dw ?
    ; =============================== ;
    
    ; ====== Random value data ====== ;
    randSize dw 3
    randVal dw ?
    randArr dw 100, 130, 160
    randIdx dw 0
    randSeed dw 1234
    ; =============================== ;
    
    speed dw ?
    
    health db 5
    
    ; Sprites horizontal & vertical positions ;
    carX dw ?
    carY dw ?
    
    holeX dw ?
    holeY dw ?
    ; ======================================= ;
    
    ; == Collisions detection data == ;
    carMidX dw ?
    carMidY dw ?
    holeMidX dw ?
    holeMidY dw ?
    
    distX dw ?
    distY dw ?
    
    detect dw 0
    ; =============================== ;
    
    timer dw ?
    
    easyMsg db 'Press 1 for easy mode.$', 0
    hardMsg db 'Press 2 for hard mode.$', 0
    diff dw ?
    
    gameOverMsg db 'GAME OVER.$', 0
    enterMsg db 'Press ENTER to start again.$', 0
    
    
.code

include .\funcs.asm
include .\draw.asm

main proc
    mov ax, @data
    mov ds, ax
    
    ; 256-color video mode (320x200) ;
    mov ah, 0h
    mov al, 13h
    int 10h
    ; ============================== ;
    
restart:
    mov carMidX, 0
    mov carMidY, 0
    mov holeMidX, 0
    mov holeMidY, 0
    
    mov timer, 1000
    
    call background
    
    call startMsg
    
    call diffKey
    
    call background
    
    call heart
    
    ; reset & print health ;
    mov health, 5
    call printHealth
    ; ==================== ;
    
    ; car starting position ;
    mov carX, 150
    mov carY, 140
    ; ===================== ;
    
    mov holeY, -52 ; hole starting position
    
    call rand
    mov ax, randVal
    mov holeX, ax
      
gameLoop:
    ; wait before diaplaying the 1st hole ;
    cmp timer, 0
    je drawHole
    dec timer
    jmp skipHole
    ; =================================== ;
    
drawHole:
    call hole
skipHole:
    call car
    
    
; ========================================= ;
; Calc distances between car & hole middles ;
; ========================================= ;

; == calc horizonal distance == ;
    mov ax, carMidX
    sub ax, holeMidX
    test ax, ax
    jns posDistX
    neg ax
    
posDistX:
    mov distX, ax
; ============================= ;
    
; == calc vertical distance == ;
    mov ax, carMidY
    sub ax, holeMidY
    test ax, ax
    jns posDistY
    neg ax
    
posDistY:
    mov distY, ax
; ============================ ;

; ========================================= ;
; ========================================= ;
    
; check if car hits outer part of the hole ;
    cmp distX, 32
    jg detectSkip
    
    cmp distY, 15
    jg detectSkip
    
    mov detect, 1
; ======================================== ;
    
; check if car hits inner part of the hole ;
    cmp distX, 24
    jg detectSkip
    
    cmp distY, 11
    jg detectSkip
    mov detect, 0
; ======================================== ;


; GAME OVER & avoid far jump for restart ;
restartHelp:
    call gameOver
    call enterKey
    jmp restart
; ====================================== ;

; avoid far jump for gameLoop ;
gameLoopHelp:
    jmp gameLoop
; =========================== ;

    
detectSkip:
    ; 1 = hit outer part ;
    cmp detect, 1
    jne gameLoop
    ; ================================================= ;
    
    ; wait to move away from the hole ;
    cmp distY, 35
    jl gameLoop
    ; =============================== ;
    
    mov detect, 0
    
    ; decrease & print health ;
    dec health
    
    call printHealth
    ; ======================= ;

    cmp health, 0
    jg gameLoopHelp
    jmp restartHelp

main endp

end main

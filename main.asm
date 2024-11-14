title AssemblyBattleship

; Zero macro
zerar MACRO reg
    xor reg,reg
ENDM

; Macros for saving and restoring registers
push_all MACRO 
    push ax
    push bx
    push cx
    push dx
    push si
    push di
ENDM

pop_all MACRO
    pop di
    pop si
    pop dx 
    pop cx
    pop bx
    pop ax
ENDM

; macro for handling usermatrix coordinates
get_coordinates MACRO
    mov di, X_COORDINATES
    mov si, Y_COORDINATES
    add di, si
ENDM

; macro for printing strings
print_msg MACRO msg
    mov ah, 9
    lea dx, msg
    int 21h
ENDM

; macro for printing characters
print_character MACRO char
    mov ah, 2
    mov dl, char
    int 21h
ENDM

; Macro for checking hit places on UserMatrix
already_hit MACRO jump
    cmp MATRIXUSER[di], 'X'
    je jump
    cmp MATRIXUSER[di], '_'
    je jump
ENDM

.model small
.data
    ; All playable random matrixes
    MJ0 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    MJ1 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0
        db 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    MJ2 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0
        db 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1,0
        db 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0
        db 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0
        db 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0

    MJ3 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0
        db 0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0
        db 0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0
        db 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0
        db 0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0
        db 0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    MJ4 db 1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
        db 0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1

    MJ5 db 0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
        db 0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    ; Matrix showed to the user
    MATRIXUSER      db 20 dup (20 dup('.'))
                    
    ; Matrix where ships are represented
    MATRIXSHIP      db 20 dup (20 dup(?))
                   
    ; Send a message requesting the user input for coordinates
    COORDINATES_REQUEST db 10,13,"Selecione a posicao desejada com as setas e atire com ENTER: ",10,13,"$"
    
    ; Send message for missed shot
    MISS_MESSAGE db 10,13,"Voce errou!",10,13,"$"

    ; Send message for hit shot
    HIT_MESSAGE db 10,13,"Voce acertou!",10,13,"$"

    ; Interface Messages
    WELCOME_MESSAGE db 10,13,"Bem vindo ao jogo da batalha naval!",10,13,"Para vencer voce deve acertar todos os navios. Boa sorte!",10,13,"$"
    DIFFICULTY_MESSAGE db 10,13,"Escolha a dificuldade: (1 - Facil) (2 - Medio) (3 - Dificil): ",10,13,"$"
    SHIPS_MESSAGE db 10,13,"Navios Restantes: ",10,13,"$"
    SHOTS_MESSAGE db 10,13,"Tiros Restantes: ",10,13,"$"
    PRESS_KEY db 10,13,"Pressione qualquer tecla para continuar",10,13,"$"

    ; End of game messages
    VICTORY_MESSAGE db 10,13,"Parabens, voce venceu!",10,13,"$"
    DEFEAT_MESSAGE db 10,13,"Que pena, seus tiros acabaram. Voce perdeu!",10,13,"$"

    ; Shot coordinates (X,Y)
    X_COORDINATES dw 0
    Y_COORDINATES dw 0

    ; Sum of the coordinates
    POSITION dw 0

    ; Remaining shots of user
    TOTAL_SHOTS dw ?

    ; Points variable
    SHIPS dw 19

.stack 0100h
                    
.code

;Print start message, select difficulty mode and initialize the game
program_init PROC
    print_msg WELCOME_MESSAGE

    ; Select difficulty
    print_msg DIFFICULTY_MESSAGE
    mov ah, 1
    int 21h
    cmp al, '1'
    je easy
    cmp al, '2'
    je medium
    cmp al, '3'
    je hard

    ; Set total shots
    easy:
        mov TOTAL_SHOTS, 340
        jmp finish_init
    
    medium:
        mov TOTAL_SHOTS, 240
        jmp finish_init

    hard:
        mov TOTAL_SHOTS, 140
        jmp finish_init

    call RandomMatrix
    finish_init:
        ; Display status
        call Results    
program_init ENDP

RandomMatrix PROC
    call Random
    cmp dx,0
    je Level0
    cmp dx,1
    je Level1
    cmp dx,2
    je Level2
    cmp dx,3
    je Level3
    cmp dx,4
    je Level4
    cmp dx,5
    je Level5

    Level0:
        lea si, MJ0
        call copy_matrix
        jmp FRM
    Level1:
        lea si, MJ1
        call copy_matrix
        jmp FRM
    Level2:
        lea si, MJ2
        call copy_matrix 
        jmp FRM
    Level3:
        lea si, MJ3
        call copy_matrix
        jmp FRM
    Level4:
        lea si, MJ4
        call copy_matrix
        jmp FRM
    Level5:
        lea si, MJ5
        call copy_matrix
        jmp FRM

    FRM:
    ret
RandomMatrix ENDP

Random PROC
    mov ah, 0 ; Function that takes the sistem time
    int 1ah   ; Receive time in cx:dx
    mov ax, dx
    zerar dx
    mov bx, 6
    div bx
    ret
ENDP

copy_matrix PROC
    lea di, MATRIXSHIP
    mov cx,400
    cld
    rep movsb
    ret
ENDP

; Take the user input for the coordinates of the shot
CursorUp PROC
    ; Check if we're already at the top row
    cmp Y_COORDINATES, 0
    je fimup

    ; Move the cursor up
    sub Y_COORDINATES, 20

    ; Update the MATRIXUSER
    get_coordinates ; Y (si) and X (di) ; Pos in di
    already_hit fimup
    mov al, '*'
    mov MATRIXUSER[di], al
    mov POSITION, di

    ; Clear the old cursor position
    add di, 20  ; Move to the old Y position
    already_hit fimup
    mov al, '.'
    mov MATRIXUSER[di], al

    fimup:
    ret 
ENDP

CursorDown PROC
    ; Check if we're already at the bottom row
    cmp Y_COORDINATES, 380
    je fimdown

    ; Move the cursor down
    add Y_COORDINATES, 20

    ; Update the MATRIXUSER
    get_coordinates
    already_hit fimdown
    mov al, '*'
    mov MATRIXUSER[di], al
    mov POSITION, di

    ; Clear the old cursor position
    sub di, 20
    already_hit fimdown
    mov al, '.'
    mov MATRIXUSER[di], al

    fimdown:
    ret
ENDP

CursorLeft PROC
    ; Check if we're already at the leftmost column
    cmp X_COORDINATES, 0
    je fimleft

    ; Move the cursor left
    dec X_COORDINATES
    
    ; Update the MATRIXUSER
    get_coordinates
    already_hit fimleft
    mov al, '*'
    mov MATRIXUSER[di], al
    mov POSITION, di

    ; Clear the old cursor position
    inc di
    already_hit fimleft
    mov al, '.'
    mov MATRIXUSER[di], al

    fimleft:
    ret
ENDP

CursorRight PROC
    ; Check if we're already at the rightmost column
    cmp X_COORDINATES, 19
    je fimright

    ; Move the cursor right
    inc X_COORDINATES

    ; Update the MATRIXUSER
    get_coordinates
    already_hit fimright
    mov al, '*'
    mov MATRIXUSER[di], al
    mov POSITION, di

    ; Clear the old cursor position
    dec di
    already_hit fimright
    mov al, '.'
    mov MATRIXUSER[di], al

    fimright:
    ret
ENDP

UserShot PROC

    ; Print the coordinates request
    print_msg COORDINATES_REQUEST

; Get Coordinates from the user, stored on Position
loop_start:
    ; Read keyboard input
    mov ah, 0
    int 16h

    ; Check if the user pressed an arrow key
    cmp ah, 48h ; up arrow
    je move_up
    cmp ah, 50h ; down arrow
    je move_down
    cmp ah, 4Bh ; left arrow
    je move_left
    cmp ah, 4Dh ; right arrow
    je move_right
    cmp al, 0Dh ; ENTER key
    je get_position

    ; If the user pressed any other key, ignore it and continue
    jmp loop_start

; Move the cursor up
move_up:
    ; Verify if the position is already hit
    call CursorUp
    call PrintMatrix
    jmp loop_start

; Move the cursor down
move_down:
    call CursorDown
    call PrintMatrix
    jmp loop_start

; Move the cursor left
move_left:
    call CursorLeft
    call PrintMatrix
    jmp loop_start

; Move the cursor right
move_right:
    call CursorRight
    call PrintMatrix
    jmp loop_start

; Get the position of the cursor
get_position:
    mov di, POSITION
    already_hit loop_start
    ret
UserShot ENDP 

; Check if the shot hit the ship. In this case, give one point and change the matrix
GetItRight? PROC
    push_all
    ; Verify if the position has a ship
    mov di, POSITION
    cmp MATRIXSHIP[di], 1
    je ship_hit
    
    ; Message user that the shot missed
        print_msg MISS_MESSAGE
        mov al, '_'
        mov MATRIXUSER[di], al
    jmp decrese_shots

    ; The shot hit the ship
    ship_hit:
    ; Update the MATRIXUSER
        mov al, 'X'
        mov MATRIXUSER[di], al

    ; Message user that the shot hit
        print_msg HIT_MESSAGE

    ; Decrease left ships
        dec SHIPS

    decrese_shots:
        dec TOTAL_SHOTS

    pop_all
    ret
GetItRight? ENDP

PrintMatrix PROC
    ; Clear the screen
    mov ah, 06h
    mov al, 00h
    mov bh, 07h ; White on black
    mov cx, 0000h
    mov dx, 184Fh
    int 10h

    ; Print the matrix
    zerar bx
    zerar si
    mov ah, 2
    ; Print columns
    jmp_col:
        cmp bx,20
        je jmp_line
        mov dl, MATRIXUSER[bx + si]
        int 21h
        inc bx
        jmp jmp_col

    ; Print lines
    jmp_line:
        cmp si,380
        je finish_matrix
        print_character 10
        add si,20
        zerar bx
        jmp jmp_col
    
    finish_matrix:
        print_character 10
    ret
PrintMatrix ENDP

; Check if all the ships were hit or if the shots are over
Results PROC
    ; Show status for the user
    print_msg SHIPS_MESSAGE
    mov ax, SHIPS
    call saidec

    print_msg SHOTS_MESSAGE
    zerar ax
    mov ax, TOTAL_SHOTS
    call saidec

    ; Press any key to continue
    print_msg PRESS_KEY
    mov ah,1
    int 21h
    ret
ENDP

; Convert number in register and print it in decimal
saidec PROC
    mov bx, 10
    zerar cx

    ; Handle zero case
    cmp ax, 0
    jne positive
    print_character 30h
    jmp encerra

    ; Handle decimal conversion
        positive:
            cmp ax,0        ; If quociente is zero, jump to print_decimal
            je print_decimal
            zerar dx        ; Zero dx to store the remainder
            div bx          ; Divide ax by 10. Quociente in ax, remainder in dx
            push dx         ; Store the remainder in stack
            inc cx          
            jmp positive
        
        print_decimal:
            mov ah, 2
            print:          ; Return the number in decimal
            pop dx         
            add dx, 30h     ; Transform to ASCII
            int 21h
            loop print
    
    encerra:
        ret
ENDP

main PROC
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; Initialize the game
    call program_init

    ; Start the program
    program_loop:
    call PrintMatrix
    call UserShot
    call GetItRight?
    call Results

    ; Verify if all the ships were hit (victory)
    cmp SHIPS, 0
    je victory

    ; Verify if all the shots are over (defeat)
    cmp TOTAL_SHOTS, 0
    je defeat

    jmp program_loop

    ; Print victory or defeat message
    victory:
    print_msg VICTORY_MESSAGE
    jmp program_end
    
    defeat:
    print_msg DEFEAT_MESSAGE

    ; Finish the program
    program_end:
        mov ah, 4CH
        int 21h 
main ENDP
END main
title AssemblyBattleship

zerar MACRO reg
    xor reg,reg
ENDM

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

get_coordinates MACRO
    mov di, X_COORDINATES
    mov si, Y_COORDINATES
    add di, si
ENDM

print_msg MACRO msg
    mov ah, 9
    lea dx, msg
    int 21h
ENDM

Random400 MACRO
    ; Generate a random number between 0 and 399
    mov ah, 0C0h ; RAND function
    int 21h
    mov cx, ax ; Random number in ax
    mov bx, 400
    mul bx
    mov ax, dx ; Random number in ax (0-399)
ENDM

Random MACRO
    mov ah, 0
    int 1ah

    mov ax, dx
    mov dx, 0
    mov bx, 10
    div bx
ENDM

.model small
.data
    ; Matrix showed to the user
    MATRIXUSER      db 20 dup (20 dup('.'))
                    
    ; Matrix where ships are represented
    MATRIXSHIP      db 20 dup (20 dup(1))
                   
    ; Send a message requesting the user input for coordinates
    COORDINATES_REQUEST db 10,13,"Selecione a posicao desejada com as setas e atire com ENTER: ",10,13,"$"
    
    ; Send message for missed shot
    MISS_MESSAGE db 10,13,"Voce errou!",10,13,"$"

    ; Send message for hit shot
    HIT_MESSAGE db 10,13,"Voce acertou!",10,13,"$"

    ; Interface Messages
    SCORE_MESSAGE db 10,13,"Pontuacao: ",10,13,"$"
    SHOTS_MESSAGE db 10,13,"Tentativas Restantes: ",10,13,"$"
    PRESS_ENTER db 10,13,"Pressione ENTER para continuar",10,13,"$"

    ; End of game messages
    VICTORY_MESSAGE db 10,13,"Parabens, voce venceu!",10,13,"$"
    DEFEAT_MESSAGE db 10,13,"Que pena, seus tiros acabaram. Voce perdeu!",10,13,"$"

    ; Shot coordinates (X,Y)
    X_COORDINATES dw 0
    Y_COORDINATES dw 0

    ; Sum of the coordinates
    POSITION dw 0

    ; Remaining shots of user
    TOTAL_SHOTS db 10

    ; Points variable
    SCORE db 0

.stack 0100h
                    
.code
; Take the user input for the coordinates of the shot
CursorUp PROC
    ; Check if we're already at the top row
    cmp Y_COORDINATES, 0
    je fimup

    ; Move the cursor up
    sub Y_COORDINATES, 20

    ; Update the MATRIXUSER
    get_coordinates ; Y (si) and X (di) ; Pos in di
    mov al, '*'
    mov MATRIXUSER[di], al
    mov POSITION, di

    ; Clear the old cursor position
    add di, 20  ; Move to the old Y position
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
    mov al, '*'
    mov MATRIXUSER[di], al
    mov POSITION, di

    ; Clear the old cursor position
    sub di, 20
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
    mov al, '*'
    mov MATRIXUSER[di], al
    mov POSITION, di

    ; Clear the old cursor position
    inc di
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
    mov al, '*'
    mov MATRIXUSER[di], al
    mov POSITION, di

    ; Clear the old cursor position
    dec di
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

    ; Verify if the position is already hit
    mov di, POSITION
    cmp MATRIXUSER[di], 'X'
    je move_left
    cmp MATRIXUSER[di], '0'
    je move_left

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
        mov al, '0'
        mov MATRIXUSER[di], al
    jmp decrese_shots

    ; The shot hit the ship
    ship_hit:
    ; Update the MATRIXUSER
        mov al, 'X'
        mov MATRIXUSER[di], al

    ; Message user that the shot hit
        print_msg HIT_MESSAGE

    ; Increase the score
        inc SCORE

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

    mov ah, 2
    zerar bx
    zerar si

    jmp_col:
        cmp bx,20
        je jmp_line
        mov dl, MATRIXUSER[bx + si]
        int 21h
        inc bx
        jmp jmp_col

    jmp_line:
        cmp si,380
        je finish_matrix
        mov dl, 10
        int 21h
        add si,20
        zerar bx
        jmp jmp_col
    
    finish_matrix:
        mov dl, 10
        int 21h
    ret
PrintMatrix ENDP

; Check if all the ships were hit or if the shots are over
Results PROC
    ; Show status for the user
    print_msg SCORE_MESSAGE
    mov ah,2
    mov dl, SCORE
    or dl, 30h
    int 21h

    print_msg SHOTS_MESSAGE
    mov ah,2
    mov dl, TOTAL_SHOTS
    or dl, 30h
    int 21h

    ; Press enter to continue
    print_msg PRESS_ENTER
    mov ah,1
    int 21h
    ret
ENDP

main PROC
    mov ax, @data
    mov ds, ax

    program_start:
    call PrintMatrix
    call UserShot
    call GetItRight?
    call Results

    ; Verify if all the ships were hit (victory)
    cmp SCORE, 19
    je victory

    ; Verify if all the shots are over (defeat)
    cmp TOTAL_SHOTS, 0
    je defeat

    jmp program_start

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
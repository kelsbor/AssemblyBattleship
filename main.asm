title AssemblyBattleship

zerar MACRO reg
    xor reg,reg
ENDM

LoopMatrix MACRO lvl
    zerar si
    lea bx, matrix

Level:
    mov al,[bx + si]
    mov MATRIXSHIP[bx + si],al
    inc si
    cmp si,400
    je zl0
    jmp Level

zl0:
ENDM

Random MACRO register
    mov ah, 0 ; Function that takes the sistem time
    int 1ah

    mov ax, dx ; Divides by 100 beacause it can be too high
    mov dx, 0
    mov bx, 100
    div bx

LR1:
    cmp register,6 ; Change SI value by increasing and decreasing it
    je LR2
    inc register
    loop LR1
    jmp Rfim
LR2:
    zerar register ; ATENTION verify this line later
    loop LR1
Rfim:
ENDM
.model small
.data
    ; All playable random matrixes
    MJ1 db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    MJ2 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0
        db   0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    MJ3 db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0
        db   0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0
        db   0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0
        db   0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0

    MJ4 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0
        db   0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0
        db   0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0
        db   0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0
        db   0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0
        db   0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    MJ5 db 1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
        db   0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1

    MJ6 db 0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0
        db   0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        db   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    ; Matrix showed to the user
    MATRIXUSER      db 20 dup (20 dup('0'))
                    
    
    ; Matrix where ships are represented
    MATRIXSHIP      db 20 dup (20 dup(?))
                   
    
    ; Send a message requesting the user input for coordinates
    COORDINATES_REQUEST db 10,13,"Digite a coordenada do tiro (x,y): ",10,13,"$"
    
    ; Shot coordinates (X,Y)
    CORDINATES_SHOT db ?,?

    ; Remaining shots of user
    TOTAL_SHOTS db ?

    ; Points variable
    SCORE db ?

.stack 0100h
                    
.code
; Take the user input for the coordinates of the shot
UserShot PROC
    push ax
    push dx

    mov ah, 9
    lea dx, COORDINATES_REQUEST
    int 21h

    pop dx
    pop ax
ret
UserShot ENDP

; Check if the shot hit the ship. In this case, give one point.
GetItRight? PROC
    ret
GetItRight? ENDP

PrintMatrix PROC
    mov ah, 2
    zerar bx
    zerar si

    jmp_col:
        cmp bx,20
        je jmp_line
        mov dl, MATRIXSHIP[bx + si]
        or dl,30h
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
    ret
PrintMatrix ENDP

; Check if all the ships were hit or if the shots are over
Finish? PROC

Finish? ENDP

RandomMatrix PROC
    ;Random si
    mov si, 0
    lea di, MATRIXSHIP
    mov cx, 400
    cmp si,0
    je Level0
    cmp si,1
    je Level1
    cmp si,2
    je Level2
    cmp si,3
    je Level3
    cmp si,4
    je Level4
    cmp si,5
    je Level5

Level0:
    LoopMatrix MJ1
    jmp FRM
Level1:
    LoopMatrix MJ2
    jmp FRM
Level2:
    LoopMatrix MJ3
    jmp FRM
Level3:
    LoopMatrix MJ4
    jmp FRM
Level4:
    LoopMatrix MJ5
    jmp FRM
Level5:
    LoopMatrix MJ6
    jmp FRM

FRM:
ret
RandomMatrix ENDP

CopyMatrix PROC
    cld 
    rep stosb
    ret
CopyMatrix ENDP

main PROC
    mov ax, @data
    mov ds, ax
    mov es, ax

    call RandomMatrix
    call PrintMatrix
    call UserShot
    call GetItRight?
    mov ah, 4CH
    int 21h 
main ENDP
END main

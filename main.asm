title AssemblyBattleship

zerar MACRO reg
    xor reg,reg
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
    MATRIXUSER      db 20 dup (20 dup('0'))
                    
    
    ; Matrix where ships are represented
    MATRIXSHIP      db 20 dup (20 dup('?'))
                   
    
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
    ret
PrintMatrix ENDP

; Check if all the ships were hit or if the shots are over
Finish? PROC

Finish? ENDP

main PROC
    mov ax, @data
    mov ds, ax

    call PrintMatrix
    call UserShot
    call GetItRight?
    mov ah, 4CH
    int 21h 
main ENDP
END main

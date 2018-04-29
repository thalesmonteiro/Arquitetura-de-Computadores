SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

section .data ;Usado para declarar e inicializar dados e constantes
    MsgUsuario db 'Digite um número: '
    lenMsgUsuario equ $-MsgUsuario
    displayMsg db 'O número digitado foi: ', 0h
    lenDisplayMsg equ $-displayMsg

section .bss ;usado para declarar variaveis
    num resb 7
   
section .text ; usado para armazenar o codigo
    global _start

_start:
    ;Pede um numero para o usuario
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, MsgUsuario
    mov edx, lenMsgUsuario
    int 80h

    ;ler e guarda o numero inserido

    mov eax, SYS_READ
    mov ebx, STDOUT
    mov ecx, num
    mov edx, 5
    int 80h

    ;Exibe a mensagem DisplayMSG
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, displayMsg
    mov edx, lenDisplayMsg
    int 80h

    mov bl, [num] ; Atribuindo o valor da variável segundo ao registrador BL
    sub bl, byte '0' ; Convertendo valor de ASCII em decimal para fins de operação
    add [num], bl
    ;Exibe o numero digitado
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, num
    mov edx, 5
    int 80h

    ;Encerra codigo

    mov eax, 1
    mov ebx, 0
    int 80h


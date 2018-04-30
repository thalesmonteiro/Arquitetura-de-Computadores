SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

%include        'funcao.asm'

section .data ;Usado para declarar e inicializar dados e constantes
    MsgUsuario db 'Digite um número: '
    lenMsgUsuario equ $-MsgUsuario
    displayMsg db 'O número apos a soma: ', 0h
    lenDisplayMsg equ $-displayMsg

section .bss                ;usado para declarar variaveis
    num resb 255
   
section .text               ;usado para armazenar o codigo
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
    mov edx, 10
    int 80h

    ;Exibe a mensagem DisplayMSG na tela
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, displayMsg
    mov edx, lenDisplayMsg
    int 80h
    
    ;Convertendo de ASCII para Inteiro
    mov eax, num
    call atoi
    add eax, 10;    
    mov [num], eax          ;resultado convertido em Inteiro

    
    call itoa               ;Convertendo de Inteiro pra ASC11 e Exibindo na tela
    mov[num], eax

    ;Encerra codigo
    mov eax, 1
    mov ebx, 0
    int 80h



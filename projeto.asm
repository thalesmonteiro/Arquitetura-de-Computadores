;****************************************************************
;*	Programa Para Calcular os N Primeiros Primos em Assembly	*
;*	 feito para a disciplina de Arquitetura de Computadores		*
;*																*
;*					Feito por Gabriel Ferraz					*
;*							  Thales Monteiro					*
;*																*
;****************************************************************

SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

%include        'funcao.asm'

section .data ;Usado para declarar e inicializar variáveis e constantes
	    MsgUsuario db 'Digite a quantidade de números primos a ser exibida: '
	    lenMsgUsuario equ $-MsgUsuario
	    newLine db 0x0A
	    lenNewLine equ $-newLine
		limite			dd	0
		count_ex		dd 	1
		count_in		dd 	2
		count_primos	dd	2

section .bss                ;Usado para alocar um espaço na memoria
	    num resb 25
   
section .text               ;Usado para armazenar o codigo
	    global _start

_start:
	    ;Pede um numero para o usuario
	    mov eax, SYS_WRITE
	    mov ebx, STDOUT
	    mov ecx, MsgUsuario
	    mov edx, lenMsgUsuario
	    int 80h

	    ;Ler e armazena o numero inserido
	    mov eax, SYS_READ
	    mov ebx, STDOUT
	    mov ecx, num
	    mov edx, 10
	    int 80h
    
	    ;Converte de ASCII para Inteiro
	    mov eax, num
	    call atoi
		mov [num], eax

loop_ex:
		;Compara count_ex e num
		mov eax, [count_ex]
		cmp eax, [num]
		;Condição para terminar o loop (count_ex > num)
		jg fim_loop_ex

		;Inicializa o valor de count_in como 2 para ser utilizado nas condições do loop		
		mov dword [count_in], 2
		;Salva o valor até onde o loop interno irá percorrer
		mov eax, [count_primos]
		mov ecx, 2
		mov edx, 0		;Zera os bits de cima (edx) para não pegar valor lixo quando for realizar a divisão
		idiv ecx
		;Guarda o valor da divisão na memória
		mov [limite], eax

		;Loop com um comportamento equivalente a for(count_in = 2; count_in <= limite; count_in++)
		.loop_in:
				;Compara count_in e limite
				mov eax, [count_in]
				cmp eax, [limite]
				;Condição para terminar o loop (count_in > limite)
				jg .fim_loop_in

				;Realiza a divisão para pegar o resto guardado em edx
				mov eax, [count_primos]
				mov ecx, [count_in]
				mov edx, 0			;Zera os bits de cima (edx) para não pegar valor lixo quando for realizar a divisão
				idiv ecx

				;Após a divisão edx guarda o resto da divisão realizada
				;Esse trecho usa esse dado para verificar se o número é primo ou não
				;Equivalente a if(count_primos % count_in == 0)
				cmp edx, 0
				je .nao_eh_primo
				;Incrementa o contador e recomeça o loop
				inc dword [count_in]
				jmp .loop_in

		.fim_loop_in:
				;Exibe o número primo encontrado
				mov eax, [count_primos]
				call itoa
	    
				;Trecho de código para pular linha no momento de exibir os números
				mov eax, SYS_WRITE
			    mov ebx, STDOUT
			    mov ecx, newLine
			    mov edx, lenNewLine
			    int 80h
	
				;Incrementa o contador do loop externo
				inc dword [count_ex]

		.nao_eh_primo:
				;Incrementa o contador de números primos
				inc dword [count_primos]
				;Reinicia o loop externo
				jmp loop_ex

fim_loop_ex:
    	;Encerra codigo
	    mov eax, 1
	    mov ebx, 0
	    int 80h



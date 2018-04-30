Programa da Disciplina arquitetura de computadores

Arquitetura Intel x86

Montagem:

nasm -f elf32 arquivo.asm -o arquivo.o
ld -m elf_i386 -s -o arquivo arquivo.o
./arquivo

.section .data
array1:
  .byte 1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,10 //ініцалізація вхідних значень
array2:
  .byte 1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4
array3:
  .byte 1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4
values:
   .word 77, 151, 22, 256 //значення які дано у формулі


.section .bss
y:
  .space 64
temp:
  .space 64


.section .text
.global _start

_start:

  movb $1, %cl 
  movq $array1, %r8     
  movq $array2, %r9 
  movq $array3, %r10  
  movq $temp, %r12
  movq $y, %r11

_loop: 

  movq $values, %r13 
  
  movb (%r8), %al 
  xorb %ah, %ah
  movw (%r13), %bx 
  imul %bx        // множення %ax на %bx і збереження до %eax
  movl %eax, (%r11) //запис результату множення до %r11 
  addq $2, %r13 //наступне значення у values (151)

  movb (%r9), %al
  xorb %ah, %ah
  movw (%r13), %bx
  imul %bx        
  addq $2, %r13 //наступне значення у values (22)
  
  add %eax, (%r11) //додавання першого множника і другого

  movb (%r10), %al
  xorb %ah, %ah
  movw (%r13), %bx
  imul %bx         // множення %ax на %bx і збереження до %eax
  addq $2, %r13 //наступне значення у values (256)

  add %eax, (%r11) // додавання першого і другого з третім множником

  movl (%r11), %eax 
  divl (%r13) //ділення на 256
  movl %eax, (%r11) //запис результату до %r11

  incq %r8 //інкремент
  incq %r9
  incq %r10 

  addq $4, %r11 

  incb %cl //інкремент рахівника
  cmpb $17, %cl    //умова виходу з циклу
  jne _loop 

  movq $16, %rbx
  movq $y, %r10      
 
  
  movq $1, %rdi
  movq $4, %rdx

_write:
  movq $1, %rax
  movq %r10, %rsi //вивід даних
  syscall   
  
  addq $4, %r10  
  dec  %rbx
  jnz _write
  
   
_exit:    
  movq $60, %rax
  movq $0, %rdi
  syscall

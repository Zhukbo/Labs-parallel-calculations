.section .data
array1:
	.word 1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,10 //вхідні масиви
array2:
	.word 1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4
array3:
	.word 1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4
values1:
	.word 77, 77, 77, 77 //значення з формули за умовою
values2:
	.word 151, 151, 151, 151 //значення з формули за умовою
values3:
	.word 22, 22, 22, 22 //значення з формули за умовою


.section .bss
y:
	.space 64


.section .text
.global _start

_start:
	movq $4, %rbx // кількість ітерацій циклу
	movq $array1, %r8
	movq $array2, %r9
	movq $array3, %r10
	movq $y, %r11
	movq $8, %rdi // константа 8 
	movq %rdi, %mm3 // запис константи в регістр %mm3
	
_loop:
	movq $values1, %r13
	movq $values2, %r14
	movq $values3, %r15

	movq (%r8), %mm0
 	movq (%r13), %mm1
	pmullw %mm1, %mm0 // множення значень масиву array1 на 77

	movq (%r9), %mm1
	movq (%r14), %mm2
	pmullw %mm2, %mm1 // множення значень масиву array2 на 151

	paddsw %mm1, %mm0 // додавання першого множника і другого

	movq (%r10), %mm1
	movq (%r15), %mm2
	pmullw %mm2, %mm1 // множення значень масиву array3 на 22

	paddsw %mm1, %mm0 // додавання першого і другого множника з третім

	psrlw %mm3, %mm0 //зсув результату на 8 вправо (ділення на 256)

	movq %mm0, (%r11) //запис результату до %r11

	addq $8, %r8 //ітерація
	addq $8, %r9
	addq $8, %r10
	addq $8, %r11	
	decq %rbx	//декремент рахівника
	jnz _loop

	movq $16, %rbx
    movq $y, %r10  
	movq $1, %rdi
    movq $2, %rdx
	
_write:
  movq $1, %rax
  movq %r10, %rsi //вивід
  syscall   
  
  addq $2, %r10  
  dec  %rbx
  jnz _write

	
_exit:
	movq $60, %rax
	movq $0, %rdi
	syscall

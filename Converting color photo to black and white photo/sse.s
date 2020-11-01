.section .data
array1:
	.float 1.0,2.0,3.0,4.0,1.0,2.0,3.0,4.0,1.0,2.0,3.0,4.0,1.0,2.0,3.0,10.0 //вхідні масиви
array2:
	.float 1.0,2.0,3.0,4.0,1.0,2.0,3.0,4.0,1.0,2.0,3.0,4.0,1.0,2.0,3.0,4.0
array3:
	.float 1.0,2.0,3.0,4.0,1.0,2.0,3.0,4.0,1.0,2.0,3.0,4.0,1.0,2.0,3.0,4.0
values1:
	.float 77.0, 77.0, 77.0, 77.0 //значення з формули за умовою
values2:
	.float 151.0, 151.0, 151.0, 151.0 //значення з формули за умовою
values3:
	.float 22.0, 22.0, 22.0, 22.0 //значення з формули за умовою
values4:
    .float 256.0,256.0,256.0,256.0//значення з формули за умовою


.section .bss
y:
	.space 64

.section .text
.global _start

_start:
	movq $8, %rbx
	movq $array1, %r8
	movq $array2, %r9
	movq $array3, %r10
	movq $y, %r11
    	
_loop:
	movq $values1, %r13
	movq $values2, %r14
	movq $values3, %r15
	movq $values4, %r12

    movups (%r12), %xmm3

	movups (%r8), %xmm0
 	movups (%r13), %xmm1
	mulps %xmm1, %xmm0 // множення значень масиву array1 на 77.0

	movups (%r9), %xmm1
	movups (%r14), %xmm2
	mulps %xmm2, %xmm1 // множення значень масиву array2 на 151.0

	addps %xmm1, %xmm0 // додавання першого множника і другого

	movups (%r10), %xmm1
	movups (%r15), %xmm2
	mulps %xmm2, %xmm1 // множення значень масиву array3 на 22.0

	addps %xmm1, %xmm0  // додавання першого і другого множника з третім

    divps %xmm3, %xmm0 // ділення на 256.0
	
	movq %xmm0, (%r11) //запис результату до %r11

	addq $8, %r8 
	addq $8, %r9
	addq $8, %r10
	addq $8, %r11	
	decq %rbx	
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

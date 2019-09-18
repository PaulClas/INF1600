.global matrix_row_aver_asm

matrix_row_aver_asm :
push %ebp      			/* Save old base pointer */
mov %esp, %ebp 			/* Set ebp to current esp */

						/* Write your solution here */
	sub $12, %esp
	movl $0, -4(%ebp)			#r = 0


FOR_R:

	movl $0, -12(%ebp)			#elem = 0
	movl $0, -8(%ebp)			#c = 0

FOR_C:

	movl 16(%ebp), %eax			#matorder->eax
	imul - 4(%ebp), %eax
	add - 8(%ebp), %eax
	mov 8(%ebp), %ebx			#inmatdata->ebx
	mov (%ebx,%eax,4),%ecx		#inmatdata[c + r * matorder]

	add %ecx, -12(%ebp)			#elem += inmatdata[c + r * matorder]
	add $1, -8(%ebp)				#c++

END_C:

	mov 16(%ebp), %eax			#matorder->eax
	cmp - 8(%ebp), %eax			#matorder - c
	jg FOR_C

	movl $0, %edx
	mov - 12(%ebp), %eax			#elem->eax
	mov 16(%ebp), %ebx			#matorder->ebx
	idiv %ebx					#elem / matorder

	movl 12(%ebp), %ebx			#outmatdata->ebx
	movl - 4(%ebp), %ecx			#r->ecx
	movl %eax, (%ebx, %ecx, 4)		#outmatdata[r] = elem / matorder


END_R :

	mov 16(%ebp), %eax			#matorder->eax
	add $1, -4(%ebp)				#r++
	cmp - 4(%ebp), %eax			#matorder - r
	jg FOR_R


leave          			/* Restore ebp and esp */
ret           			/* Return to the caller */


.globl matrix_transpose_asm

matrix_transpose_asm:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        /* Write your solution here */
        
			sub $8, %esp
			movl $0, -4(%ebp)			#int r = 0
		
		FOR_R:
		
			movl $0, -8(%ebp)			#int c = 0
			
		FOR_C:
			
			movl 16(%ebp),%eax			#matorder -> eax
			imul -8(%ebp),%eax
			add -4(%ebp),%eax			#r + c* matorder
			mov 8(%ebp),%ebx			#inmatdata -> ebx
			mov (%ebx,%eax,4),%ebx		#inmat[r + c * matorder] -> ebx
			
			movl 16(%ebp),%eax			#matorder-> eax
			imul -4(%ebp),%eax
			add -8(%ebp),%eax 			#c + r* matorder
			mov 12(%ebp),%ecx			#outmatdata-> ecx
			mov %ebx,(%ecx,%eax,4)		#outmat[c + r * matorder]=inmat[r + c * matorder]
			
			add $1,-8(%ebp)				#c++
			
		END_C:
			
			movl 16(%ebp),%eax			#matorder-> eax
			cmp -8(%ebp),%eax			#matorder - c
			jg FOR_C
			
		
		END_R:
			movl 16(%ebp),%eax			#matorder-> eax
			add $1,-4(%ebp)				#c++
			cmp -4(%ebp),%eax			#matorder - r
			jg FOR_R
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

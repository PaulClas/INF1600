.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl _ZNK7CCircle12PerimeterAsmEv

_ZNK7CCircle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        # A 8(%ebp) on a l'adresse du cercle 
        mov 8(%ebp), %eax
        # A (%eax) on a la vTable, a 4(%eax) on a le rayon du cercle
        fld 4(%eax) # On met le rayon dans st[0]
        
        fld factor # On met factor dans st[0], le rayon dans st[1]
        fmulp #On multiplie R * 2
        fldpi #On met pi dans st[0]
        fmulp #On obtient le rayon
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

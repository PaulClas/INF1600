.data
        factor: .float 2.0 /* use this to multiply by two */
.text

.globl	_ZNK9CTriangle9HeightAsmEv

_ZNK9CTriangle9HeightAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        # A 8(%ebp) on a l'adresse du triangle 
        mov 8(%ebp), %eax
        # A (%eax) on a la vTable, a 4(%eax) on a le tableau de float avec les cotes du triangle mSides[3]
        mov (%eax), %ebx
        
        push %eax #On met this sur la pile pour pouvoir utiliser CTriangle::PerimeterAsm 
        # On va chercher la methode CTriangle::PerimeterAsm qui est a 12 (%ebx)
        call *20(%ebx) #Le perimetre du triangle est maintenant dans st[0]
        add $4, %esp # On recupere l'espace alloue sur la pile
        
        #On a maintenant l'aire dans st[0]
        
        #2.0f*A/mSides[2]
        
        fld 12(%eax) #On place le troisieme cote dans st[0] (la base)
        fdivrp
        
        fld factor
        fmulp
        
        
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */

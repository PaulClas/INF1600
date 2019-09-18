
#include <stdio.h>

unsigned int Decryption_fct(unsigned int le)
{
	unsigned int be = 0;

	/*
	 * Remplacez le code suivant par de l'assembleur en ligne
	 * en utilisant le moins d'instructions possible
	
	 be = (le & 0xff000000) | (le&0xff) << 16  | (le & 0xff00) | (le & 0xff0000) >> 16;
	*/
	

	asm volatile(
		// instructions...
		"movl %1, %%eax \n\t"
		"movl %%eax, %%ebx\n\t"
		"sall $16, %%ebx \n\t"
		"andl $0xFF0000, %%ebx \n\t"
		"movl %%eax, %%ecx\n\t"
		"sarl $16, %%ecx\n\t"
		"andl $0xFF, %%ecx\n\t"
		"andl $0xFF00FF00, %%eax\n\t"
		"orl  %%ebx, %%eax\n\t"
		"orl %%ecx, %%eax\n\t"
		"movl %%eax, %0"
		
		: "=q"(be)// sorties (s'il y a lieu)
		: "g"(le)// entrées
		: "eax","ebx","ecx"// registres modifiés (s'il y a lieu)
	);

	return be;
}

int main()
{
	unsigned int data = 0xeeaabbff;

	printf("Représentation crypte en little-endian:   %08x\n"
	       "Représentation decrypte en big-endian:    %08x\n",
	       data,
	       Decryption_fct(data));

	return 0;
}

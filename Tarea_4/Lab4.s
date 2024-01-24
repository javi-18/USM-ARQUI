	.data
opcion: .word 1
p1: .asciz "mar"
p2: .asciz "rama"
num1: .word 2   @n
num2: .word 5	@k
vector: .word 1,3,5
dimension: .word 3

	.text

main:
	ldr r5,=opcion
	ldr r5,[r5]
	cmp r5,#1
	beq funcion1
	cmp r5,#2
	beq funcion2
	cmp r5,#3
	beq funcion3
	

funcion1:
    ldr r1, =0x200701B0
    ldr r2, =0x2007032C
    mov r3, #95
    mov r4, #95
     @ldr r3, [r3]
     @ldr r4, [r4]
    
    sub1:
        push {r1-r7}
        ; @bl sub3
        ldr r1, =p1
        ldr r2, =0x200701B0
        bl sub2
        mov r8, r0
        pop {r1-r7}

        push {r1-r7}
        ; @bl sub3
        ldr r1, =p2
        ldr r2, =0x2007032C
        bl sub2
        mov r9, r0
        pop {r1-r7}

        push {r1-r7}
        ; @bl sub3
        mov r1, r8
        mov r2, r9
        bl sub3
        pop {r1-r7}

        push {r1-r7}
        mov r2, r0
        mov r0, #0
        mov r1, #0
        bl printInt
        pop {r1-r7}

        wfi
@En r1 va a estar el string y en r2 va a estar un vector de contadores

    sub2:
        mov r4, #0

    loop:
        ldrb r5, [r1, r4]
        cmp r5, #0
        beq ret
        sub r5, r5, #32
        lsl r5, r5, #2
        ldr r6, [r2, r5]
        add r6, r6, #1
        str r6, [r2, r5]
        add r4, #1

        b loop

    ret:
        mov r0, r2
        mov pc, lr

@En r1 va estar el vector 1 y en r2 el vector 2, en r3 estara el largo de r1 y en r4 el largo de r2
    sub3:
        cmp r3, r4
        bne false
        mov r5, #0
        lsl r3, r3, #2

    check:
        cmp r5, r3
        beq true
        ldr r6, [r1, r5]
        ldr r7, [r2, r5]
        cmp r6, r7
        bne false
        add r5, r5, #4
        b check
	
    true:
        mov r0, #1
        mov pc, lr

    false:
        mov r0, #0
        mov pc, lr



funcion2:
	ldr r1, =num1
    	ldrb r1, [r1]
    	ldr r2, =num2
    	ldrb r2, [r2]
    	mov r0, #0
    	bl rec
    	mov r2, r0
	mov r7,r2
    	mov r0, #0
    	mov r1, #0
    	bl printInt
    	wfi

    	rec:
     	 push {r1, r2, lr}
      	cmp r2, r1
      	bgt cond_0
      	cmp r2, #0
      	beq cond_ret1
      	cmp r1, r2
      	beq cond_ret1
      	b else

    	else:  @caso para cuando n>k
      	 sub r1, r1, #1
      	 bl rec
      	 pop {r1, r2, r7}
       	push {r1, r2, r7}
       	sub r1, r1, #1
       	sub r2, r2, #1
      	 bl rec
       	pop {r1, r2, r7}
       	mov lr, r7
       	mov pc, lr

    	cond_0: @ caso para k>n
      	pop {r1, r2, r7}
      	mov lr, r7
      	mov pc, lr

    cond_ret1: @ caso para n=k o k=0
      	add r0, r0, #1
      	pop {r1, r2, r7}
      	mov lr, r7
      	mov pc, lr



funcion3:
    subr1:
        ldr r0, =dimension
        ldrb r0, [r0] @ posición en el arreglo

        mov r1, #0 @ Contador para movernos en el arreglo1
        mov r7, #0 @ Contador para movernos por el arreglo de salida
        mov r2, #0 @ Contador de números pares
        mov r3, #0
        mov r4, #1 @ 0 para saber si son pares

    loop1:
        ldr r5, =0x200701A0
        ldr r3, =vector
        ldrb r3, [r3, r1]
        mov r6, r3
        and r6, r6, r4
        cmp r6, #0
        beq es_par @ Si hace este salto es un número par
        b es_impar @ Si hace este salto es número impar

    es_par:
        add r2, r2, #1 @ Aumentamos en 1 el contador de números pares
        mov r9, r2
        strb r3, [r5, r7]
        ldrb r3, [r5, r7]
        add r1, r1, #4 @ Aumentamos en 4 bytes las dirección del elemento del arreglo a leer
        add r7, r7, #4
        sub r0, r0, #1 @ Aumentamos en 1 a la cantidad de números que hemos leído
        cmp r0, #0
        bne loop1 @ Si quedan números por leer se hace el salto.
        b next @ Si no quedan números, imprimimos el resultado

    es_impar: @ Análogo a cuando es par, pero sin aumentar el contador de pares.
        add r1, r1, #4
        sub r0, r0, #1
        cmp r0, #0
        bne loop1
        b next

    next:
        mov r0, #0
        mov r1, #0
        bl printInt
        mov r4, #1
        mov r7, r9
        mov r6, #0
        cmp r7, #0
        bne printvec
        b final

    printvec:
        ldr r5, =0x200701A0
        ldrb r5, [r5, r6]
        mov r1, r4
        mov r0, #0
        mov r2, r5
        cmp r5, #1
        beq final
        bl printInt
        add r4, r4, #1
        sub r7, r7, #1
        add r6, r6, #4
        cmp r7, #0
        bne printvec

    final:
        wfi

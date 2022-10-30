#Factorial en RISCV
#Hector Zetino 1295617

.global programa #Directiva punto de arranque del programa
.data		 #Inicio segmento de datos
hola:
	.string "Hola Mundo!!!"
text1:
	.string " * "
text2: 
	.string "1 = "
text3: 
	.string "! = "

.text		#Segmento de codigo		

programa:
	.macro Factorial(%num1)
	li a2, 1
	li a3, 1
	li a1, %num1
	li t3, 0
	mv t2, a1
	mv a0 , t2  	#Que numero es el factorial
	li a7, 1
	ecall
	la a0 , text3  #impresion de igualdad
	li a7, 4
	ecall
	beq a1, t3, impresiontext0	#compara si es igual que cero(si no pongo esto con el cero empieza a escribir numeros negativos=)
	FactorialProc:
		mv t1, a1
		mv a0 , t1  
		li a7, 1
		ecall
		xor a0,a0,a0
		la a0 , text1  
		li a7, 4
		ecall
		mul a6, a1, a3		#Se realiza la multiplicacion del primer valor por el 1
		mv a3, a6		#Se cambia la posicion del registro en con la primera iteracion a6 =
		sub a4, a1, a2
		mv a1, a4
		bnez a1, FactorialProc
		j impresiontext
	impresiontext:			#impresion del factorial cualquier numero
		la a0 , text2  
		li a7, 4
		ecall
		mv a0, a6
		li a7, 1
		ecall
		j salir
	impresiontext0:		#Impresion del factorial de 0		
		mv a0, a6
		li a7, 1
		ecall
		j salir
	salir:
	.end_macro
	Factorial(0)
	#li a7, 93
	#ecall 
	j finalizar
finalizar:
	li a7, 10 #Paramentro para finalizar programa
	ecall	  #int 21h

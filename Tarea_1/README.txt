Javiera Bobadilla;202173584-4;Paralelo 200
Elias Valle;202173537-2; Paralelo 200

Para el desarrollo de esta tarea se crearon funciones que permiten la conversion de los numeros del arhcivo numeros.txt, ya sea a binario, decimal, complemento 2, las cuales son:
- def binario(n): funcion que convierte el numero en binario
-def base_a_decimal(numero, base): funcion que convierte el numero a su representacion decimal
-def complemento_dos_a_numero(numero):funcion que convierte el numero binario a su forma en complemento 2

También se creó la funcion que realiza la suma en complemento 2, la cual es valido(numero, base)
Otras de las funciones que se crearon fueron:
-valido(numero, base): validar la base del numero entregado a una valida 
-extraer(texto): saca la informacion del archivo numeros.txt
-no_representable(texto, ingreso):devuelve la cantidad de numeros no representables o invalidos en la conversion a binario, además de contar la sumas
                                  que generen overflow

Cada una de las funciones fueron programadas sin usar metodos que python entrega para hacer la conversion a binario o a decimal entre otras

Una vez creada todas las funciones y con los datos extraidos del archivo, se crea un bucle principal para ejecutar el programa y asi poder entregar los resultados 

Los supuestos realizados para realizar la tarea fueron:
-Todos los numeros seran del mismo tamaño que el usuario defina
-Al sumar los numeros convertidos a binario, se asume que ya esos numeros ya estan en complemento 2

#binario(n): Convierte un número decimal n en su representación binaria como una cadena de caracteres.
def binario(n):
    a=[]
    numero = ""
    while(n>0):
        dig=n%2
        a.append(dig)
        n=n//2
    a.reverse()
    for i in a:
        numero += str(i)
    return numero


#base_a_decimal(numero, base): Convierte un número en una cadena de caracteres numero en una base a su representación decimal.
def base_a_decimal(numero, base):
    resultado = 0
    i = len(numero)-1
    potencia = 1

    while i >= 0:
        if numero[i] == "A":
            resultado += 10*potencia
        elif numero[i] == "B":
            resultado += 11*potencia
        elif numero[i] == "C":
            resultado += 12*potencia
        elif numero[i] == "D":
            resultado += 13*potencia
        elif numero[i] == "E":
            resultado += 14*potencia
        elif numero[i] == "F":
            resultado += 15*potencia
        else:
            resultado += int(numero[i])*potencia

        potencia *= base
        i -= 1

    return resultado





with open("numeros.txt", "r") as file:
    texto = file.readlines()

#extraer(texto):Extrae información de las líneas de texto del archivo numeros.txt y devuelve una 
#lista de tuplas con la siguiente estructura: (base1, num1, base2, num2).
def extraer(texto):
    lista_numeros = []
    for linea in texto:
        base = linea.strip().split("-")
        base1, num1 = base[0].split(";")
        base2, num2 = base[1].split(";")
        lista_numeros.append((int(base1), num1, int(base2), num2))
    return lista_numeros


#valido(numero, base): Verifica si un número en una cadena de caracteres numero es válido en la base dada. 
# Devuelve True si es válido, y False en caso contrario.
def valido(numero, base):
    primero = str(numero)
   

    for digito in primero:
        if(int(digito, 16)>=base):
            return False
    return True



#complemento_dos_a_numero(numero): Convierte un número binario en complemento a dos (cadena de caracteres) en su representación decimal.
def complemento_dos_a_numero(numero):
    
    signo = -1 if numero[0] == "1" else 1
    resultado = 0
    i = len(numero)-1
    potencia = 1
    carry = 1
    numero = list(numero)
    while i >= 1:
        if signo == 1:
            resultado += int(numero[i])*potencia

        else:
            if carry == 1:
                if ((1-int(numero[i])) == 1):
                    numero[i] = "0"
                else:
                    numero[i] = "1"
                    carry = 0
            else:
                numero[i] = str(1-int(numero[i]))
            resultado += (int(numero[i]))*potencia
        potencia *= 2
        i -= 1

    return resultado*signo


#suma_complemento_dos_con_bases(binario1, base1, binario2, base2, bits): Realiza la suma en complemento dos de 2 números binarios,
# binario1 y binario2, dadas sus bases base1 y base2, y verifica si hay desbordamiento (overflow) considerando el límite de bits proporcionado. 
# Devuelve True si no hay desbordamiento y False en caso contrario.
def suma_complemento_dos_con_bases(binario1, base1, binario2, base2, bits):
  
    if(len(binario1)>bits or len(binario2)>bits):
        return False

    while(len(binario1)<bits):
        binario1 = binario1[0]+binario1

    while(len(binario2)<bits):
        binario2 = binario2[0]+binario2
    carry = 0
    resultado = ""
    i=bits-1
    while(i >= 0):

        if(binario1[i] == "1" and binario2[i] == "1"):
            if(carry==0):
                resultado = "0" + resultado
            else:
                resultado = "1" + resultado
            carry=1
            

        elif(binario1[i] == "0" and binario2[i] == "1"):

            if(carry==0):
                resultado = "1" + resultado
                carry = 0
            else:
                resultado = "0" + resultado
                carry = 1

        elif(binario1[i] == "1" and binario2[i] == "0"):

            if(carry==0):
                resultado = "1" + resultado
                carry = 0
            else:
                resultado = "0" + resultado
                carry = 1
        else:
            if(carry==0):
                resultado = "0" + resultado
            else:
                resultado = "1" + resultado
            carry=0

        i -= 1
  
    if (complemento_dos_a_numero(binario1)+complemento_dos_a_numero(binario2)) != complemento_dos_a_numero(resultado):
        return False


    else:
        return True


#no_representable(texto, ingreso): Procesa el contenido del archivo numeros.txt y devuelve la cantidad de números no representables, no válidos y desbordamientos.
def no_representable(texto, ingreso):
    lista = extraer(texto)
    no_reprentado = 0
    no_valido = 0
    overflow = 0
    for linea in lista:
        base1,num1,base2,num2 = linea
        flag = True
        if(valido(num1,base1)):
            
            num1_bin = binario(base_a_decimal(num1,base1))
            if(len(num1_bin)>int(ingreso)):
                flag = False
                no_reprentado += 1
        else:
            no_valido += 1
            flag = False
        if(valido(num2,base2)):
            num2_bin = binario(base_a_decimal(num2,base2))
            if(len(num2_bin)>int(ingreso)):
                flag = False
                no_reprentado += 1
        else:
            no_valido += 1
            flag = False
        if flag:
            if not suma_complemento_dos_con_bases(num1_bin,base1, num2_bin,base2, int(ingreso)):
                overflow += 1
        
    return(no_reprentado,no_valido, overflow)


#El bucle while principal del programa ejecuta el proceso de lectura de entrada y evaluación de los datos en el archivo numeros.txt, 
# y escribe los resultados en un archivo llamado resultado.txt. El bucle se detiene cuando se cumple una condición específica 
# (en este caso, cuando el total de errores es mayor que el doble de la cantidad de líneas en numeros.txt).

flag = True
errores_totales = 0

while(flag):
    numero = input("Ingrese un numero, El rango permitido es entre 1 y 32: ")
    

    
    if(numero.isdigit() == False):

        print("El valor ingresado no es un numero")


    elif int(numero)>=0 and int(numero)<=32:
        if(int(numero) != 0):
            A = str(len(texto)*2)
            C,B,D = no_representable(texto, numero)
            errores_totales += C
            errores_totales += B
            errores_totales += D


            with open("resultado.txt", "a") as archivo:
                archivo.write(A+";"+str(B)+";"+str(C)+";"+str(D)+"\n")

        else:
            A = len(texto)*2
            if(errores_totales>A):
                flag = False
    else:
        print("Valor ingresado fuera del rango, por favor intentelo de nuevo.")



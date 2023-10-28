package InterfazGrafica;
import java_cup.runtime.*;
import java.util.*;

import java.io.FileInputStream;
import java.util.*;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
%%

%cup
%public
%class Lexico
%line
%column
%char


%{

public String eliminarCerosAlFinal(String s) {
    if(s.charAt(s.length()-1) == '0') {
        if(s.length() == 1){
            return s;
        }else{
            return eliminarCeros(s.substring(0, s.length() - 1));
        }
    }else{
        return s;
    }
}

public Boolean validarConstanteFloat(String s) {
    String[] partes = s.split("\\.");
    System.out.println(partes[0]);
    System.out.println(partes[1]);
    String parteEntera = eliminarCeros(partes[0]);
    String parteFraccionaria = eliminarCerosAlFinal(partes[1]);
    if((parteEntera == "32767")) {
        return partes[1] == "0";
    }else{
        if(validarConstanteInt(parteEntera)) {
            return parteFraccionaria.length() < 5;
        }else {
            return false;
        }
    }
}

public Boolean validarConstanteInt(String a) {
    if(a.length() > 5) {
        return false;
    }else if(a.length() < 5){
        return true;
    }else{
        return (Integer.parseInt(a) < 32768);
    }
}

public Boolean validarConstanteHexa(String a) {
    if(a.length() > 8) {
        return false;
    }else if(a.length() < 8){
        return true;
    }else{
        return (a.charAt(0) <=7);
    }
}

public String eliminarCeros(String s) {
    if(s.charAt(0) == '0') {
        if(s.length() ==1){
            return s;
        }else{
            return eliminarCeros(s.substring(1));
        }      
    }else{
        return s;
    }
}

public String[] guardarTokenInfo(String nombre, String token, String tipo, String valor, String tamanio) {
    String[] tokenInfo = new String[5];
    tokenInfo[0] = nombre;
    tokenInfo[1] = token;
    tokenInfo[2] = tipo;
    tokenInfo[3] = valor;
    tokenInfo[4] = tamanio;
    return tokenInfo;
}

public String obtenerContenidoDeArchivo(String nombreArchivo) {
    try {
        FileInputStream inputStream = new FileInputStream(nombreArchivo);
        byte[] buffer = new byte[(int) new File(nombreArchivo).length()];
        inputStream.read(buffer);
        inputStream.close();
        return new String(buffer, "UTF-8");
    } catch (IOException e) {
        System.err.println("Error al leer el archivo: " + e.getMessage());
        return null;
    }
}

// Función para guardar la tabla de tokens
public void guardarTablaTokens(String[] tokenInfo) {
    try {
        // Nombre del archivo en el que se guardará la tabla
        String nombreArchivo = "./ts.txt";
        
        // Crear un objeto FileWriter para escribir en el archivo
        FileWriter archivo = new FileWriter(nombreArchivo, true);

        
        // Verificar si el archivo está vacío
        File file = new File(nombreArchivo);
        
        
        String contenido = obtenerContenidoDeArchivo(nombreArchivo);
        if (contenido.isEmpty()) {
            // El archivo está vacío, escribir el encabezado
            archivo.write("Nombre\tToken\tTipo\tValor\tTamaño\n");
        }

        String candidato = tokenInfo[0] + "\t" + tokenInfo[1] + "\t" + tokenInfo[2] + "\t" + tokenInfo[3] + "\t" + tokenInfo[4] + "\n";
        if (!contenido.contains(candidato)) {
            // Agregar info al archivo
            archivo.write(candidato);
        }
        

        // Cerrar el archivo
        archivo.close();
        
        System.out.println("Tabla de tokens guardada en " + nombreArchivo);
    } catch (IOException e) {
        System.err.println("Error al guardar la tabla de tokens: " + e.getMessage());
    }
}

String res = "";
String errores = "";

public String retornarStr(){
    return res;
}

public String retornarErrores(){
    return errores;
}

%}


// El simbolo ~ incluye cualquier caracter

LETRA = [a-zA-Z]
DIGITO = [0-9]
ESPACIO = [ \t\f\n\r]+
ID = {LETRA}(("_"{LETRA})|("_"{DIGITO})|{LETRA}|{DIGITO})*
COMILLA = \"
CONST_INT = {DIGITO}+
CONST_FLOAT = {DIGITO}*"."{DIGITO}*
CONST_BIN = "("[0-1]+",2)"
CONST_HEXA = "("({DIGITO}|A|B|C|D|E|F)+",16)"
CONST_BOOL = "TRUE"|"FALSE"

COMENTARIO = "/*" ~ "*/" 
CONST_STRING = {COMILLA}(.)*{COMILLA}


%%

<YYINITIAL> {

//"."            {System.out.println("Token PUNTO encontrado, Lexema "+ yytext());}

":"             {System.out.println("Token DP encontrado, Lexema "+ yytext());
                    res += "Token DP encontrado, Lexema "+ yytext() + "\n";}

","             {System.out.println("Token COMA encontrado, Lexema "+ yytext());
                    res += "Token COMA encontrado, Lexema "+ yytext() + "\n";}

\"              {System.out.println("Token COMILLA encontrado, Lexema "+ yytext());
                    res += "Token COMILLA encontrado, Lexema "+ yytext() + "\n";}

":="			{System.out.println("Token ASIGN encontrado, Lexema "+ yytext());
                    res += "Token ASIGN encontrado, Lexema "+ yytext() + "\n";}

"_"             {System.out.println("Token SEPARADOR encontrado, Lexema "+ yytext());
                    res += "Token SEPARADOR encontrado, Lexema "+ yytext() + "\n";}

"TRUE"          {System.out.println("Token PRBOOLEANOV encontrado, Lexema "+ yytext());
                    res += "Token PRBOOLEANOV encontrado, Lexema "+ yytext() + "\n";}

"FALSE"         {System.out.println("Token PRBOOLEANOF encontrado, Lexema "+ yytext());
                    res += "Token PRBOOLEANOF encontrado, Lexema "+ yytext() + "\n";}

"FOR"			{System.out.println("Token PRFOR encontrado, Lexema "+ yytext());
                    res += "Token PRFOR encontrado, Lexema "+ yytext() + "\n";}

"INT"			{System.out.println("Token PRINT encontrado, Lexema "+ yytext());
                    res += "Token PRINT encontrado, Lexema "+ yytext() + "\n";}

"FLOAT"         {System.out.println("Token PRFLOAT encontrado, Lexema "+ yytext());
                    res += "Token PRFLOAT encontrado, Lexema "+ yytext() + "\n";}

"BIN"           {System.out.println("Token PRBIN encontrado, Lexema "+ yytext());
                    res += "Token PRBIN encontrado, Lexema "+ yytext() + "\n";}

"HEXA"          {System.out.println("Token PRHEXA encontrado, Lexema "+ yytext());
                    res += "Token PRHEXA encontrado, Lexema "+ yytext() + "\n";}

"STRING"         {System.out.println("Token PRSTRING encontrado, Lexema "+ yytext());
                    res += "Token PRSTRING encontrado, Lexema "+ yytext() + "\n";}

"BOOLEAN"       {System.out.println("Token PRBOOLEAN encontrado, Lexema "+ yytext());
                 res += "Token PRSTRING encontrado, Lexema "+ yytext() + "\n";}

"MOD"           {System.out.println("Token PRMOD encontrado, Lexema "+ yytext());
                    res += "Token MOD encontrado, Lexema "+ yytext() + "\n";}

"AND"			{System.out.println("Token PRAND encontrado, Lexema "+ yytext());
                    res += "Token PRAND encontrado, Lexema "+ yytext() + "\n";}

"OR"			{System.out.println("Token PROR encontrado, Lexema "+ yytext());
                    res += "Token PROR encontrado, Lexema "+ yytext() + "\n";}

"WHILE"			{System.out.println("Token PRWHILE encontrado, Lexema "+ yytext());
                    res += "Token PRWHILE encontrado, Lexema "+ yytext() + "\n";}

"IF"			{System.out.println("Token PRIF encontrado, Lexema "+ yytext());
                    res += "Token PRIF encontrado, Lexema "+ yytext() + "\n";}

"ELSE"			{System.out.println("Token PRELSE encontrado, Lexema "+ yytext());
                    res += "Token PRELSE encontrado, Lexema "+ yytext() + "\n";}

"WRITE"			{System.out.println("Token PRWRITE encontrado, Lexema "+ yytext());
                    res += "Token PRWRITE encontrado, Lexema "+ yytext() + "\n";}

"DEFINE"			{System.out.println("Token PRDEFINE encontrado, Lexema "+ yytext());
                    res += "Token PRDEFINE encontrado, Lexema "+ yytext() + "\n";}

"ENDDEFINE"			{System.out.println("Token PRENDDEFINE encontrado, Lexema "+ yytext());
                    res += "Token PRENDDEFINE encontrado, Lexema "+ yytext() + "\n";}

"PROGRAM"			{System.out.println("Token PRPROGRAM encontrado, Lexema "+ yytext());
                    res += "Token PRPROGRAM encontrado, Lexema "+ yytext() + "\n";}

"END"			{System.out.println("Token PREND encontrado, Lexema "+ yytext());
                    res += "Token PRENDPRENDDEFINE encontrado, Lexema "+ yytext() + "\n";}

"RETURN"			{System.out.println("Token PRRETURN encontrado, Lexema "+ yytext());
                    res += "Token PRRETURN encontrado, Lexema "+ yytext() + "\n";}                 

"("				{System.out.println("Token PA encontrado, Lexema "+ yytext());
                    res += "Token PA encontrado, Lexema "+ yytext() + "\n";}

")"				{System.out.println("Token PC encontrado, Lexema "+ yytext());
                    res += "Token PC encontrado, Lexema "+ yytext() + "\n";}

"{"				{System.out.println("Token LLAVEA encontrado, Lexema "+ yytext());
                    res += "Token LLAVEA encontrado, Lexema "+ yytext() + "\n";}

"}"				{System.out.println("Token LLAVEC encontrado, Lexema "+ yytext());
                    res += "Token LLAVEC encontrado, Lexema "+ yytext() + "\n";}

"["				{System.out.println("Token CA encontrado, Lexema "+ yytext());
                    res += "Token CA encontrado, Lexema "+ yytext() + "\n";}

"]"				{System.out.println("Token CC encontrado, Lexema "+ yytext());
                    res += "Token CC encontrado, Lexema "+ yytext() + "\n";}

"="				{System.out.println("Token IGUAL encontrado, Lexema "+ yytext());
                    res += "Token IGUAL encontrado, Lexema "+ yytext() + "\n";}

"=="			{System.out.println("Token EQUIVALENTE encontrado, Lexema "+ yytext());
                    res += "Token EQUIVALENTE encontrado, Lexema "+ yytext() + "\n";}

"<"			    {System.out.println("Token MENOR encontrado, Lexema "+ yytext());
                    res += "Token MENOR encontrado, Lexema "+ yytext() + "\n";}

">"			    {System.out.println("Token MAYOR encontrado, Lexema "+ yytext());
                    res += "Token MAYOR encontrado, Lexema "+ yytext() + "\n";}

"<="			{System.out.println("Token MENIGUAL encontrado, Lexema "+ yytext());
                    res += "Token MENIGUAL encontrado, Lexema "+ yytext() + "\n";}

">="			{System.out.println("Token MAYIGUAL encontrado, Lexema "+ yytext());
                    res += "Token MAYIGUAL encontrado, Lexema "+ yytext() + "\n";}

"<>"			{System.out.println("Token DISTINTO encontrado, Lexema "+ yytext());
                    res += "Token DISTINTO encontrado, Lexema "+ yytext() + "\n";}

";"				{System.out.println("Token PYC encontrado, Lexema "+ yytext());
                    res += "Token PYC encontrado, Lexema "+ yytext() + "\n";}

"+="			{System.out.println("Token MASIGUAL encontrado, Lexema "+ yytext());
                    res += "Token MASIGUAL encontrado, Lexema "+ yytext() + "\n";}

"/"             {System.out.println("Token DIVISION encontrado, Lexema "+ yytext());
                    res += "Token DIVISION encontrado, Lexema "+ yytext() + "\n";}

"*"             {System.out.println("Token MULTIPLICACION encontrado, Lexema "+ yytext());
                    res += "Token MULTIPLICACION encontrado, Lexema "+ yytext() + "\n";}

"+"             {System.out.println("Token SUMA encontrado, Lexema "+ yytext());
                    res += "Token SUMA encontrado, Lexema "+ yytext() + "\n";}

"-"             {System.out.println("Token RESTA encontrado, Lexema "+ yytext());
                    res += "Token RESTA encontrado, Lexema "+ yytext() + "\n";}

{ID}			{System.out.println("Token ID encontrado, Lexema "+ yytext());
                    guardarTablaTokens(guardarTokenInfo(yytext(), "ID", "nulo",  "nulo", "nulo"));
                    res += "Token ID encontrado, Lexema "+ yytext() + "\n";}

{CONST_INT}		{   String valorEntero = eliminarCeros(yytext());
                    // Verifica si el valor está dentro del rango de 16 bits 
                    if (validarConstanteInt(valorEntero)) {
                        String[] tokenInfo = guardarTokenInfo("_" + valorEntero, "CONST_INT", "nulo",  valorEntero, "nulo");
                        guardarTablaTokens(tokenInfo);
                        System.out.println("Token CONST_INT, encontrado Lexema " + valorEntero);
                        res += "Token CONST_INT encontrado, Lexema "+ valorEntero + "\n";
                    } else {
                        errores += "CONST_INT fuera de rango de 16 bits en la línea " + yyline + "\n";
                        System.out.println("Error: CONST_INT fuera de rango de 16 bits en la línea " + yyline);
                    }
                }

{CONST_FLOAT}	{
                    if(validarConstanteFloat(yytext())) {
                        guardarTablaTokens(guardarTokenInfo("_" + yytext(), "CONST_FLOAT", "nulo", yytext(), "nulo"));
                        System.out.println("Token CONST_FLOAT, encontrado Lexema "+ yytext());
                        res += "Token CONST_FLOAT encontrado, Lexema "+ yytext() + "\n";
                    }else{
                        errores += "CONST_FLOAT fuera de rango en la línea " + yyline + "\n";
                        System.out.println("Error: CONST_FLOAT fuera de rango en la línea " + yyline);
                    }
}

{CONST_BIN}		{   String valor = eliminarCeros(yytext().substring(1));
                    if(valor.length() < 19) {
                        guardarTablaTokens(guardarTokenInfo("_(" + valor, "CONST_BIN", "nulo", "(" + valor, "nulo")); 
                        System.out.println("Token CONST_BIN, encontrado Lexema "+ valor);
                        res += "Token CONST_BIN encontrado, Lexema "+ "(" + valor + "\n";
                    }else{
                        errores += "CONST_BIN fuera de rango en la línea " + yyline + "\n";
                        System.out.println("Error: CONST_BIN fuera de rango en la línea " + yyline);
                    }
                }

{CONST_HEXA}	{   String valor = eliminarCeros(yytext().substring(1));
                    if(validarConstanteHexa(valor)) {
                        guardarTablaTokens(guardarTokenInfo("_(" + valor, "CONST_HEX", "nulo", "(" + valor, "nulo")); 
                        System.out.println("Token CONST_HEX, encontrado Lexema "+ "(" + valor);
                        res += "Token CONST_HEXA encontrado, Lexema "+ "(" + valor + "\n";
                    }else{
                        errores +=  "CONST_HEX fuera de rango en la línea " + yyline + "\n";
                        System.out.println("Error: CONST_HEX fuera de rango en la línea " + yyline);
                    }
                }

{CONST_BOOL}    {System.out.println("Token CONST_BOOL, encontrado Lexema "+ yytext());
                    guardarTablaTokens(guardarTokenInfo(yytext(), "CONST_BOOL", "nulo",  yytext(), "nulo"));
                    res += "Token CONST_BOOL encontrado, Lexema "+ yytext() + "\n";
                    }

{CONST_STRING}	{System.out.println("Token CONST_STRING, encontrado Lexema "+ yytext());
                    String content = yytext();
                    content = content.substring(1, content.length()-1);
                    guardarTablaTokens(guardarTokenInfo("_"+content, "CONST_STRING", "nulo", content, String.valueOf(yylength())));
                    res += "Token CONST_STRING encontrado, Lexema "+ yytext() + "\n";}

{ESPACIO}		{/* no se realiza accion por lo tanto se ignoran*/}

{COMENTARIO}	{/* No se realiza accion por lo tanto se ignoran*/}

}

[^]		{ throw new Error("Caracter no permitido: <" + yytext() + "> en la linea " + yyline); }























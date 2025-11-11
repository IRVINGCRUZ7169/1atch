Set Library To "D:\1atch\foxjson-master\foxjson.dll" ADDITIVE 
LOCAL lcArchivoJSON, loJSON, lnFile, lcContenido, laDatos

lcArchivoJSON = "d:\1atch\xml\Productos_tigo.json"

*// Verificar si el archivo existe
IF !FILE(lcArchivoJSON)
    MESSAGEBOX("El archivo JSON no se encuentra.", 16, "Error")
    RETURN
ENDIF

*// Leer el contenido del archivo JSON
lnFile = FOPEN(lcArchivoJSON, 0) &&// Abre el archivo en modo lectura
lcContenido = FREAD(lnFile, FSIZE(lcArchivoJSON))
FCLOSE(lnFile)

*// Crear un objeto JSON para analizar el contenido (requiere la librería FoxJSON)
TRY
    loJSON = CREATEOBJECT("FoxJSON")
    laDatos = loJSON.Parse(lcContenido)

    *// Verificar si la??ación fue exitosa y si es un array
    IF VARTYPE(laDatos) = 9 && ASCAN(laDatos, 1) > 0 // 9 es el tipo de dato Object (para arrays en FoxJSON)
        USE produtos_tigo IN 0 EXCLUSIVE
        IF USED("produtos_tigo")
            FOR EACH loRegistro IN laDatos
                APPEND BLANK
                *// Asignar los valores del objeto JSON a los campos de la tabla
                *// Asumimos que las claves del objeto JSON coinciden con el orden de los campos
                REPLACE campo0 WITH loRegistro[1]
                REPLACE campo1 WITH loRegistro[2]
                REPLACE campo2 WITH loRegistro[3]
                REPLACE campo3 WITH loRegistro[4]
                REPLACE campo4 WITH loRegistro[5]
                REPLACE campo5 WITH loRegistro[6]
                REPLACE campo6 WITH loRegistro[7]
                REPLACE campo7 WITH loRegistro[8]
                REPLACE campo8 WITH loRegistro[9]
                REPLACE campo9 WITH loRegistro[10]
                REPLACE campo10 WITH loRegistro[11]
                REPLACE campo11 WITH loRegistro[12]
                REPLACE campo12 WITH loRegistro[13]
            ENDFOR
            USE
            MESSAGEBOX("Datos importados exitosamente a la tabla produtos_tigo.", 64, "Éxito")
        ELSE
            MESSAGEBOX("No se pudo abrir la tabla produtos_tigo.", 16, "Error")
        ENDIF
    ELSE
        MESSAGEBOX("El archivo JSON no tiene la estructura esperada (un array de objetos).", 16, "Error")
    ENDIF

CATCH TO loError
    MESSAGEBOX("Ocurrió un error al procesar el archivo JSON: " + loError.Message, 16, "Error")
FINALLY
    *// Liberar el objeto JSON si fue creado
    IF VARTYPE(loJSON) = 9
        RELEASE loJSON
    ENDIF
ENDTRY
CLOSE ALL data
SELECT 2
USE claro EXCLUSIVE 
GO top
DO WHILE !EOF()
   posicion=ALLTRIM(STR(claro.idproducto))
   agarra=SUBSTR(posicion,4,3)
   ? posicion
   ? agarra
   replace claro.idproducto WITH VAL(agarra)
   
  * =MESSAGEBOX("quieres Cambiar "+STR(posicion)+" X "+STR(agarra))
   SKIP +1
ENDDO
      
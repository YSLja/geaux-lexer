lexer grammar gLexer;

@header {
   package Parse.antlr_build;
}

@members {
   StringBuilder sb;

   //Need to translate escape sequences to ints (maybe chars too) (for strings)
   private int stringToInt(String target) {
      if (target.startsWith("x")) {						//hexidecimal
         return Integer.parseInt(target.substring(1), 16);
      }

      if (target.length() > 0 && Character.isDigit(target.charAt(0))) {		//octal
              return Integer.parseInt(target, 8);
      }

      switch (target.charAt(0)) {
         case 'n': return '\n';
         case 't': return '\t';
         case 'r': return '\r';
         case 'b': return '\b';
         case 'f': return '\f';
         case 'a': return 7;
         case 'v': return 11;
         case '\\': return '\\';
         case '"': return '"';
         case '?': return '?';
      }

      return target.charAt(0);
   }
}

fragment ALPHA 
   : [A-Za-z]
   ;
fragment DIGIT
   : [0-9]
   ;

fragment ALNUM
   : [A-Za-z_0-9]
   ;

fragment IDENTIFIER_START
   : [A-Za-z_]
   ; 

fragment HEXADECIMAL
   : [0-9A-Fa-f]
   ;

fragment ESC_SEQ
   :	'\\' ['"\\abfnrtv?]		//other escape sequences
   |	'\\' [0-7]+			//octal escape sequences
   | 	'\\' 'x' HEXADECIMAL+		//hexidecimal escape sequences
   ;

//Whitespace
WS : [ \t\r\n]+ -> skip ;

// Comments
LINE_COMMENT
   : '//' ~[\r\n]* -> skip
   ;

BLOCK_COMMENT
   : '/*' .*? '*/' -> skip
   ;

// Keywords
VAR : 'var';
FUN : 'fun';
WHILE : 'while';
CONST : 'const';
STRING : 'string';
VOID : 'void';
RETURN : 'return';
IF : 'if';
ELSE : 'else';
BREAK : 'break';
INT : 'int';
TYPEDEF : 'typedef';
STRUCT : 'struct';
UNION : 'union';

// Operators (mult-char first)
AND : '&&';
OR : '||';
ARROW : '->';

LT : '<';
STAR : '*';
PLUS : '+';
TILDE : '~';
ASSIGN : '=';
DOT : '.';

// Punctuators
LBRACE : '{';
RBRACE : '}';
COMMA : ',';
LPAREN : '(';
RPAREN : ')';
BITWISEAND : '&';
BITWISEOR : '|';
BANG : '!';
SEMI : ';';
COLON : ':';
LBRACK : '[';
RBRACK : ']';

//need to expand to include octal & hexidecimal
INTEGER_CONSTANT
   : '0' [xX] HEXADECIMAL+	//hexidecimal
   | '0' [0-7]*			//octal (including plain 0)
   | [1-9] DIGIT*		//decimal
   ;

//only takes starting quotes to enter STRING_MODE
STRING_START
   : '"'
   { sb = new StringBuilder(); }
   -> pushMode(STRING_MODE), skip
   ;

// Identifier
IDENTIFIER : IDENTIFIER_START ALNUM* ;

// Fallback
ERROR_CHAR : . ;


//MODES (only used in our project for STRING_LITERAL)

mode STRING_MODE;

//escape sequences
STRING_ESC
   : ESC_SEQ
   {
	String esc = getText().substring(1);
	sb.append((char) stringToInt(esc));
   } -> skip
   ;

//normal chars
STRING_NORMAL
   : ~["\\\r\n]
   {
	sb.append(getText());
   } -> skip
   ;

//closing quote, returns fully complete STRING_LITERAL
STRING_LITERAL
   : '"'
   { 
	setText(sb.toString());
   } -> popMode
   ;

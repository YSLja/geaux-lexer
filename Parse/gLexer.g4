
lexer grammar gLexer;

@header {
   package Parse.antlr_build;
}


@members {
   StringBuilder sb;
   private int stringToInt(String target) {
      // TODO: Implement me!
      return 0;
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

WS : [ \t\r\n]+ -> skip ;

// Keywords
VAR      
   : 
   'var'
   ;
FUN      
   : 
   'fun'
   ;
WHILE    
   : 
   'while'
   ;
CONST    
   : 
   'const'
   ;
STRING   
   : 
   'string'
   ;
VOID     
   : 
   'void'
   ;
RETURN   
   : 
   'return'
   ;
IF       
   : 
   'if'
   ;
ELSE     
   : 
   'else'
   ;
BREAK    
   : 
   'break'
   ;
INT      
   : 
   'int'
   ;
TYPEDEF  
   : 
   'typedef'
   ;
STRUCT   
   : 
   'struct'
   ;
UNION    
   : 
   'union'
   ;

// Operators (mult-char first)
ANDAND   
   : 
   '&&'
   ;
OROR     
   : 
   '||'
   ;
ARROW    
   : 
   '->'
   ;

LT       
   : 
   '<'
   ;
STAR     
   : 
   '*'
   ;
PLUS     
   : 
   '+'
   ;
TILDE    
   : 
   '~'
   ;
ASSIGN   
   : 
   '='
   ;
DOT      
   : 
   '.'
   ;

// Punctuators
LBRACE   
   : 
   '{'
   ;
RBRACE   
   : 
   '}'
   ;
COMMA 
   : 
   ','
   ;
LPAREN   
   : 
   '('
   ;
RPAREN   
   : 
   ')'
   ;
AMP   
   : 
   '&'
   ;
BAR   
   : 
   '|'
   ;
BANG  
   : 
   '!'
   ;
SEMI  
   : 
   ';'
   ;
COLON 
   : 
   ':'
   ;
LBRACK   
   : 
   '['
   ;
RBRACK   
   : 
   ']'
   ;

INTEGER_CONSTANT  : DIGIT+ ;

// Identifier
IDENTIFIER : ALPHA ALNUM* ;

// Fallback
ERROR_CHAR : . ;
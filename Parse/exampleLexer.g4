lexer grammar exampleLexer;

// Hello Everyone, This is a document to help
// explain the features of ANTLR you will need 
// for this project. ANTLR has a ton of features,
// but our lexer is simple; we don't need many of 
// them. Everything that is UNCOMMENTED is code 
// DIRECTLY FROM THE SOLUTION. Everything that is 
// commented is code I made up for this document.

// The commented code is not useless however. It directly
// explains what you need to know about ANTLR to get
// through this project. Pay attention to it too.

// The @header code will appear at the 
// top of the generated java file.
// We need to include the package name otherwise,
// javac won't compile :(

@header {
   package Parse.antlr_build;
}
// You are welcome to add more header code
// As an example, If you want to use an import:
/*
   @header {
      package Your.Package.Name.and.Path;
      import java.util.something_useful;
   }
*/

// The resulting java code is going to be a class.
// We can include members to that class, 
// and also methods:

@members {
   private StringBuilder sb;

// You might need that stringbuilder :)

// We can also declare functions that we can use:
   private int stringToInt(String target) {
      // TODO: Implement me!
   }
}

// To declare a lexer rule we follow this syntax:

ADD // This is the token name
   : // We then put a colon
   '+' // Regex goes after the colon
   ; // All rules end with a semicolon

// '+' means that the above regex matches with
// the '+' string. Be careful, because this does
// not work:

/* 
ADD
   :
   "+" // ANTLR strings must be enclosed with '' 
          not "".
   ;
*/

// ANTLR supports most "textbook" regex symbols:
// Here are some examples:

/*
ADD_OR_SUB : '+' | '-' ;

ADD_FOLLOWED_BY_SUB : ('+')('-') ;

MAYBE_ADD : ('+')? ;

MANY_ADDS : ('+')+ ;
*/

// You can read the details of these rules here:
// https://www.antlr2.org/doc/metalang.html

// Some regex can be complicated, ANTLR has some 
// syntax to help with complicated regex.

// For example, we could write the following regex:

/*
ANNOYING_REGEX :
   ('A'|'B'|'C'|'D'...
   ;
*/

// For certain values, we can use a "-" to 
// represent every value between x and y.
// Example:

/*
ALPHA 
   : [A-Za-z]
   ;
*/

// So that is a regex for any alphabetical char.
// We can do this with numbers too:

/*
DIGIT
   : [0-9]
   ;
*/

// We can name regex patterns and refer to them by
// name. To do this, we declare them as fragments
// Let's declare ALPHA and DIGIT as fragments:

fragment DIGIT
   : [0-9]
   ;

fragment ALPHA 
   : [A-Za-z]
   ;

// We can now use DIGIT and ALPHA in other regex.
// Example:

/*
NUMBER : (DIGIT)+ ;
WORD : (ALPHA)+ ;
*/

// Modes:
// To implement strings (and comments),
// the easiest way is to use the ANTLR modes.

// We can define different 'modes', and the gist
// is that only certain rules apply in certain
// modes. We can define the string mode, and then
// make string specific rules that only work in 
// that mode. 

// Before defining a mode, we need to decide
// when we are going to 'switch' into that mode.
// For comments, a comment starts when we see //
// or /*. Lets implement // comments

/*
START_OF_LINE_COMMENT :
   '//' -> pushMode(LINE_COMMENT_MODE), skip
   ;
*/

// -> tells antlr that we would like to perform an
// ANTLR action. In this case, changing mode.
// The pushMode() and skip are the ANTLR action we
// are executing. pushMode changes the mode, 
// skip tells ANTLR not to generate a token for 
// this rule. 

// Now that we can change modes, let's define
// the mode:
/*
mode LINE_COMMENT_MODE
*/
// Any rule that follows will only work when ANTLR
// is in the COMMENT_MODE mode.

// This is the rule to end a LINE_COMMENT

/*
LINE_COMMENT : [\n] -> popMode
*/
// popMode ends the current mode and returns to
// the previous mode. 

/*
EAT_EVERY_CHAR_EXCEPT_NEWLINE : 
   . -> skip
   ;
*/
// The last thing I want to show you is semantic
// actions. When we match a lexer rule, we can 
// tell ANTLR to execute some java code.
// Here is an example:

/*
SEMANTIC_ACTION :
   '+' {
      System.out.println("SEMANTIC_ACTION RULE");
   } -> skip
   ;
*/

// This will execute the print statement everytime
// this rule is used to match the '+' symbol

// Inside these semantic actions, we can invoke
// ANTLR specific functions. An important one that
// you will need is the getText() function. This
// function will return the actual underlying text
// that was matched. For example:


/*
EAT_EVERY_CHAR_EXCEPT_NEWLINE_AND_PRINT_IT : 
   . {
      System.out.println(getText());
   }
   -> skip
   ;
*/

// You will need the getText() function when you try
// to implement strings. For details on how strings
// need to be implemented, refer to the project handout.

// In order to achieve the effect we want with escape 
// sequences inside strings, we will need to call 
// getText(), and then perform some surgery on the string

// Normally, the string attached to the token is the 
// string straight from the document... BUT.. if we don't
// like that string for some reason 

//       (*cough*) escape sequences (*cough*)

// Then we can alter the underlying string to a new
// string with the setText() function. An Example:

STRING_LITERAL
  : '"' {
      setText(sb.toString());
   } -> popMode
   ;

// ANTLR works by starting with at the top of the 
// file, and trying each rule until it successfully
// matches a regex against the input text.

// This means that if a bunch of rules have the 
// regex: '+', then only the first one will be used

// ANTLR has many features, but only the features
// showcased in this file were used in my solution.
// You are welocme to use more features of ANTLR,
// but this is enough to implement our simple lexer

// Good luck everyone!

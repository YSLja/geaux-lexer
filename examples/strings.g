"Make sure that escape sequences appear correctly in your output!"
"Try \n Does it appear as a slash followed by an n, or as an actual new line?"
"Same thing with \t and the others"

"Number escape sequences like \xff are ways to insert an ascii character using"
"the ascii number. Make sure that you see the appropriate character when using"
"these escape sequences: \101 = 'A'"

/*
If you are looking for some help on how to implement this, notice that I included a
string builder in the skeleton code lexer. When lexing a string, ANTLR will read them
character by character, so when encountering \n it will read it as '\' which gets read
as '\\', followed by 'n'. You will need to go through the lexed string and convert these
'\\n' into '\n'. Same with the other escape sequences.
*/

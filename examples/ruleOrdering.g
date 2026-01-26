"ANTLR tries each rule in the order they are defined until one fits"
"If you have a rule for & and &&, if the rule for & appears first, then"
"It would be impossible to lex the following:"

&&

// It should lex as AND. If you see BITWISEAND BITWISEAND, then you might have an ordering problem

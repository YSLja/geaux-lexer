package Parse;

import Parse.antlr_build.*;
import org.antlr.v4.runtime.*;

public class LexerDriver {

    private static String normalizeTokenName(String name) {
        if (name == null) return "UNKNOWN";
        return switch (name) {
            case "IDENTIFIER" -> "ID";
            case "INTEGER_CONSTANT" -> "DECIMAL_LITERAL";

            case "LBRACE" -> "LCURLY";
            case "RBRACE" -> "RCURLY";
            case "LBRACK" -> "LSQUARE";
            case "RBRACK" -> "RSQUARE";

            case "BANG" -> "NOT";
            case "PLUS" -> "ADD";
            case "SEMI" -> "SEMICOLON";

            default -> name;
        };
    }

    public static void main(String[] args) throws Exception {
        CharStream input = CharStreams.fromFileName(args[0]);
        gLexer lexer = new gLexer(input);

        Token token;
        while ((token = lexer.nextToken()).getType() != Token.EOF) {
            String raw = gLexer.VOCABULARY.getSymbolicName(token.getType());
            String name = normalizeTokenName(raw);

            System.out.printf(
                "%-15s %-10s line=%d col=%d%n",
                name,
                token.getText(),
                token.getLine(),
                token.getCharPositionInLine()
            );
        }
        System.out.println("EOF");
    }
}


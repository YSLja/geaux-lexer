
package Parse;
import Parse.antlr_build.*;
import org.antlr.v4.runtime.*;

public class LexerDriver {

    public static void main(String[] args) throws Exception {

        // 1. Input (string or file)
        CharStream input = CharStreams.fromFileName(args[0]);

        // 2. Create lexer
        gLexer lexer = new gLexer(input);

        // 3. Pull tokens and print
        Token token;
        while ((token = lexer.nextToken()).getType() != Token.EOF) {
            System.out.printf(
                "%-15s %-10s line=%d col=%d%n",
                gLexer.VOCABULARY.getSymbolicName(token.getType()),
                token.getText(),
                token.getLine(),
                token.getCharPositionInLine()
            );
        }
      System.out.println("EOF");
    }
}

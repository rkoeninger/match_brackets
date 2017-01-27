# Paren/Bracket Matcher

Here are the implementations of two functions: `parens-match?` and `brackets-match?`. Each checks a string to see if pairs of delimiters all match and are properly nested.

`parens-match?` scans the string left to right, keeping track of the nesting depth of parens. It returns false if a close paren is encountered when the depth is already zero. When the end of the string is reached, it returns true if the depth is zero, and false if the depth is greater than zero.

`brackets-match?` scans the string left to right, keeping track of the last open/left delimiter encountered by pushing onto a stack. When a close delimiter is encountered, it returns false if it doesn't match the delimiter on top of the stack or if the stack is empty. When the end of the string is reached, it returns true if the stack is empty, false if there are unmatched delimiters on the stack.

While implementing `brackets-match?`, I realized that it is a generalization of the algorithm for `parens-match?`. `parens-match?` is a special case of `brackets-match?` where you only ever put parens on the stack. Using a stack isn't meaningful if it only ever has the same value pushed onto it. The only relevant piece of information then is the stack size, so a single numeric counter is used for `parens-match?`.

[BF.STYLE---THE ULTIMATE STYLE GUIDE FOR BRAINFUCK CODE

 It is often the case when cooperating on big projects in any
 programming language, including Brainfuck, that code chaos leads to
 product degradation. Spaghetti code is increasingly dangerous for big
 projects, and absolutely disastrous when it's a high-stakes situation
 typical to Brainfuck Enterprise Solutions, delivering a high-quality
 Brainfuck-based products to the world of software.

 It is only natural that style guidelines emerge in the circumstances
 of cooperating on code. If there are no style guidelines, the code
 becomes unmaintainable by spiraling into a collections of
 inconsistent code snippets that no one admits the ownership of.

 If there are style guidelines like bf.style, it's easy to enforce
 high standards of enterprise-worthy code. The code is consistent
 across products, projects, blocks, and lines of code. All the
 developers can cooperate and have reasonable expectations from their
 colleagues. Products thrive. Flowers bloom. Illnesses are cured. Life
 is perfect.

 [1 BRAINFUCK CODE STYLE

  There are different levels of complexity to manage with style
  guidelines in Brainfuck projects. The scopes for proper style are:
  - Lines.
  - Blocks (loops).
  - Control structures.
  - Functions.
  - Programs/libraries.

  Each of these scopes has its own emerging complexities that should
  be managed in a certain specific way. Thus, bf.style is structured
  around these scopes and their respective styles.

  Linux kernel coding style
  (https://www.kernel.org/doc/html/v4.10/process/coding-style.html)
  UNIX philosophy, and common sense are taken as inspiration for the
  commandments in this guide.

  The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
  NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and
  "OPTIONAL" in this document are to be interpreted as described in
  RFC 2119 (https://datatracker.ietf.org/doc/html/rfc2119).

  [1.1 LINES

   [1.1.1 EVERY LINE SHOULD DO ONLY ONE THING (AND, PREFERABLY, DO IT WELL)

    Every line of Brainfuck code SHOULD do exactly one thing. There
    MAY be any number of characters in Brainfuck code lines, but there
    is a clear limit on how much a line SHOULD do: only one thing.

    This "one thing" could be
    - Copying a value or a set of values.
    - Moving to a certain cell.
    - Searching for a beacon cell.
    - Cleaning a memory segment.
    - And other operations that are clearly restricted in scope and
    side effects.

    If the action is compound, like "move to the cell and empty it",
    it MAY occupy one line, but only if it concerns one cell or a set
    of cells that are clearly delineated.

    An embedded algorithm taken from an algorithm library (as in 1.5.2
    and https://github.com/bf-enterprise-solutions/str.bf) MAY occupy
    one line too, because, to the program in question, it is indeed a
    single opaque action that this algorithm performs.]

   [1.1.2 ALL LINES SHOULD BE EXHAUSTIVELY COMMENTED

    Even though the line does only one thing, this one thing may still
    be opaque and confusing for the colleagues of the programmer
    writing the line in question. Thus, every line SHOULD be
    commented. The comment SHOULD clearly state what this line does.

    All the comments MUST conform to bf.doc
    (https://github.com/bf-enterprise-solutions/bf.doc).]]

  [1.2 BLOCKS (LOOPS)

   Given the universal character of Brainfuck loops, they are used for
   many purposes, be it conditional execution, looping, data copying,
   search, and validation. Given these multi-faceted purposes, the
   style may vary. For the purposes where loops become full-fledged
   control structures, see section 1.3 of this guide.

   [1.2.1 LOOP INDENTATION

    All the code inside the loop body MUST be indented one space more
    than the code outside the loop. Recursively, if there's a loop
    inside another loop, the outer loop MUST be indented one space
    more than the code outside it, and the inner loop MUST be indented
    two spaces more than the outer code.

    Both opening and closing brackets SHOULD be aligned with the code
    outside the loop. If there are commands before the opening
    bracket, it MAY shift. If the closing bracket has commands before
    it, it MAY also shift. However, the code inside the loop, if it's
    a multi-line one, MUST always be indented one space deeper than
    the code outside the loop.

    Examples:
    [bf:
     regular code indentation
     [ loop
      code inside the loop
     ] closing bracket
     outer code again]

    [bf:
     regular code indentation
     >+[ loop with commands preceding it
      code inside the loop indented the same
      <<] closing bracket with commands preceding it (indented)
     outer code again]

    Tabs are not permitted for indentation in Brainfuck code.

    Blank lines MAY be indented with the current spacing depth, or
    they MAY stay all blank, up to the code writer. format.bf decides
    to not indent the blank lines in an effort to stay compatible with
    many Brainfuck linters highlighting the trailing whitespace as an
    error.

    You can use the bundled format.bf script to format your programs.]

   [1.2.2 IF-LOOPS

    When the block of code is a one-pass loop that runs based on a
    certain condition, we can call this loop an "if-loop",
    "when-loop", or "conditional-loop".

    "If-loops" MUST be written with the opening bracket on its own
    line and the intent of the loop clearly stated in the comment. For
    example:

    [bf:
     [if the string is not zero
      [[-]>]] delete it]

    Note that the closing bracket of the if-loop MAY compound with the
    preceding commands/loops, as an exception from the general rule of
    loop formatting. This is because the intent and scope of the loop
    is expressed clearly enough in the opening comment, and need no
    clarification in the closing one.

    If the loop is small enough, then it MAY be compacted to a single
    line, with the block comment preceding it on a line by itself:

    [bf:
     delete the string if nonzero:
     [[[-]>]]]]

   [1.2.3 ITERATION LOOPS

    If the loop follows its original purpose and is an iteration loop,
    akin to C for loop, then opening and closing comments MUST clearly
    state this. Both brackets (the opening and the closing ones) MUST
    stand on a line of their own. The opening comment SHOULD state the
    purpose of the loop, while the closing one SHOULD state the
    condition for iteration. For example:

    [bf:
     [ go through every character in the string
      + add one
      > to the next char
     ] until the end of the string]

    A type of C while loops replicated in Brainfuck SHOULD also have
    their iteration condition clearly stated in the closing comment.]

   [1.2.4 COPY LOOPS

    These are usually simple enough to belong to lines, but may grow
    into block loops, when
    - the values and distances are big enough,
    - when the copying is actually iterative or multiplicative,
    - or when there are several values being copied, instead of one.

    Such loops SHOULD be commented as a single block of code (see
    section 2.2 of bf.doc for exact comment conventions) either above
    it or as a part of the opening comment. Closing comments MAY be
    omitted in such cases.]

   [1.2.5 OTHER CASES

    In most other cases, loops stay with the iteration, but perform
    some function that's not easy to anticipate. In such a case the
    sanest rule to adopt is the one customary for namespaces and
    macros in C/C++ world. Which is: opening bracket and closing
    bracket MUST stand on the lines of their own, and both SHOULD be
    commented with the same text, like "character search loop", but
    the closing one SHOULD have " ends" appended to the text. For
    example:

    [bf:
     ----- ----- test first char for newline
     [ newline search loop
      +++++ +++++ restore previous char
      > next char
      ----- ----- test for newline
     ] newline search loop ends]]]

  [1.3 CONTROL STRUCTURES

   In any and every programming language, the tools for abstraction
   are imperfect. Functions, conditions, iteration constructs,
   aliases, and macros---all of those routinely betray programmers and
   leave them barehanded against the grotesque logic of real-world
   applications. Brainfuck is no exception to the rule. The
   switch-case constructs, the with-patterns, the iterators that
   Brainfuck programmer routinely writes are control structures that
   deserve a name and a bit of respect.

   [1.3.1 NAMING OF CONTROL STRUCTURES

    Whether it's a C-style switch-case of a nested break-able loop, it
    MUST be named clearly, either as a block comment above the
    expression starting it, or as an opening bracket comment in case
    it's a loop-based structure. The name SHOULD be concise and
    referring to a construct on some other language/library familiar
    to the programmer and their colleagues.]

   [1.3.2 INNER STRUCTURE OF CONTROL STRUCTURES

    Control structures are rarely well off with just a header
    comment. In most languages, control structures have a certain
    inner structure that gets reproduced in Brainfuck code
    too. Python's with-patterns:

    [python:
     with expression [as variable]:
         with-block]

    or C switch-case statement:

    [c:
     switch (c) {
     case 'a':
       break;
     case 'b'
       return;
     default:
       break;}]

    The elements of the control structure SHOULD be properly marked in
    comments to the code that mimics their logic.]

   As a general example of the two rules above, here's a code snippet
   slightly adapted from one of the BES products:

   [bf:
    +> set the case flag
    switch:
    [ if exists
     '1'
     ----- ...
     [...]
     < to case flag
     [ case '1':
      do something
     ]
     > back to the tested char]]]

  [1.4 FUNCTIONS

   Functions are not first-class constructs in Brainfuck, but that
   doesn't mean those are unused. See, for example, Daniel
   B. Cristofani's tutorial on functions
   (https://brainfuck.org/function_tutorial.b), showing the
   state-of-art functional programming style of Brainfuck, with all
   its axiomatic advantages.

   It is RECOMMENDED to use the notation that Daniel B. Cristofani
   suggested, as is mostly compliant with bf.doc and represents the
   purpose of the functions well enough.]

  [1.5 PROGRAMS/LIBRARIES

   Brainfuck programs belong to files with .bf extension. Every file
   is a self-contained program (because Brainfuck has not and need not
   file inclusion mechanism or multi-file packages).

   Most of Brainfuck programs are written with a certain goal in mind:
   - To make a working Brainfuck-based end user application.
   - To create a drop-in embeddable library.
   - To write a literate programming research notebook.
   - Or a mixture of the three.

   Based on these types of programs, the coding style differs.

   [1.5.1 EXECUTABLE PROGRAMS

    Executables usually benefit from the presence of the exit flag
    that aborts the event loop or another control structure central to
    the executable. The central control structure SHOULD be clearly
    delineated.

    [1.5.1.1 EVENT LOOPS PROGRAMS

     Event loop-based executables are those that run indefinitely
     until stopped by the user, and process the user-supplied data
     (maybe even in several interactions).

     Event loops usually tend to be exit flag-dispatching loops, thus
     having clear means of exiting the program. Keyboard interrupts
     may also be a way to exit from those, but SHOULD be used
     cautiously, because they destroy the memory state formed around
     the event loop, especially if the event loop executable is
     embedded into another Brainfuck program.

     The examples of event loop programs are:
     - Text editors (like
       https://github.com/bf-enterprise-solutions/ed.bf)
     - REPL programs (like REPL executable in
       https://github.com/bf-enterprise-solutions/meta.bf).
     - Poll apps.
     - Games.
     - And most other user-interacting programs.

     [1.5.1.1.1 MEMORY USE AND TERMINATION

      The memory used by event loop programs SHOULD be, preferably,
      cleaned up after the event loop terminates. Event loop itself
      SHOULD terminate at the cell semantically equal (not necessarily
      the same index-wise) to the one it started on.

      In case the event loop is expected to process some data and
      leave processing results as a return value (in such cases, a
      batch-processing program may be a better use), the memory MAY
      stay as it is, but working memory with intermediate computations
      MUST nonetheless be cleared.

     Memory segments and cells SHOULD have clear names and MAY provide
     memory layout diagrams (as per section 2.4 of bf.doc) in the
     accompanying documentation. It's RECOMMENDED to have as little
     memory states as possible, because having too many memory states
     obstructs proper memory debugging and application maintenance.]]

    [1.5.1.2 BATCH PROCESSING PROGRAMS

     Batch processing programs tend to be mostly user-agnostic
     programs that operate on the provided (read-only/read-once) data
     and return processing results either
     - as data in memory, or
     - as printed text.

     Some classes of batch processing programs are:
     - ASCII art programs.
     - Halting mathematical computations.
     - One-shot programs requiring user input only once.

     The discipline for those is simple:
     - Memory state MUST be preserved as it was before the computation.
     - In case the input is processed to the data in memory, return
     data MAY be retained, while working data MUST be cleaned up.]

    [1.5.1.3 NON-TERMINATING PROGRAMS

     Non-terminating programs, like
     - digits of Pi calculation,
     - transcendental number e computation (http://brainfuck.org/e.b),
     - random data generation,
     - or any other non-halting computation

     MAY never terminate unless by user interruption, thus memory
     management rules applicable to other program types are not
     applicable to these.

     The only rule concerning non-terminating programs is: the
     computation MUST be exhaustively explained and MAY be proven to
     calculate the expected data.]]

   [1.5.2 EMBEDDABLE LIBRARIES

    Given that Brainfuck as a language and ecosystem possesses the
    original, zero-cost means of abstraction in the form of text
    copy-pasting, all the libraries should be optimized for ease of
    clipboard use.

    Which means: the memory layout of those MUST be exhaustively
    documented, SHOULD be easy to setup, and SHOULD only consume as
    much memory as actually needed by the computation.

    Return values layout and contents MUST also be documented and
    SHOULD be checked for proper termination. It is RECOMMENDED that
    embeddable library algorithms preserve as much of original data as
    it meaningfully can.

    The algorithms themselves should be easy to copy and paste, which
    means that they MAY omit the header comment loops and SHOULD stay
    compact. The build system (possibly Makefile, as in meta.bf and
    str.bf) MAY minify the files for greater convenience, but, even
    without this minification, algorithms themselves SHOULD be concise
    enough to occupy less than a screenful of lines (less than 25
    lines) in the code that uses them.

    minify.bf bundled with bf.style is a canonical minification
    implementation, and any result of other minification approach
    SHOULD match the output of minify.bf.

    Good example of embeddable library compliant with bf.style is
    str.bf (https://github.com/bf-enterprise-solutions/str.bf).]

   [1.5.3 LITERATE NOTEBOOKS

    In case of literate programming notebooks in Brainfuck (like
    https://github.com/maksimKorzh/dbfi/blob/master/cgbfi.b%28commented%29),
    the writing/programming style of the author is the biggest
    authority, so literate notebooks MAY ignore any of the rules
    above.

    However, most of the comment conventions stay, and in these cases
    literate notebook authors MAY refer to bf.doc
    (https://github.com/bf-enterprise-solutions/bf.doc) for the
    best-practice documentation and commentary solutions.

    Some RECOMMENDATION to the authors of notebooks could be:
    - Results of the computations MAY be printed for greater
    debuggability of the notebooks and for the halting guarantees of
    those.
    - The blocks of code that the notebook comments SHOULD be
    self-sufficient algorithms, so most of the style restrictions
    applicable to embeddable libraries MAY be applied to the code
    blocks in literate notebooks.]

   In all the other (rare) cases where these categories (executable,
   library, notebook) don't apply, all the conditions SHOULD be
   carefully considered, and one of these three categories MUST be
   picked after all.]]

 [2 CODE STYLE FOR LANGUAGES OTHER THAN BRAINFUCK

  Given that all the other languages used alongside Brainfuck are
  inferior in regards to security and simplicity, their use MUST be
  minimized at all costs.

  In case of using any language other than Brainfuck, it SHOULD be
  brought as close to Brainfuck as possible. Long variable names,
  helper functions, and structural/functional/object-oriented
  programming MUST be avoided to not interfere with the
  straightforward structure of the Brainfuck code they try to
  augment.]]

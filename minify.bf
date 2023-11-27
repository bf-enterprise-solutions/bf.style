[SPDX-FileCopyrightText: Brainfuck Enterprise Solutions
 SPDX-License-Identifier: WTFPL]
[format.bf---Brainfuck code minifier.

 Removes all the non-command character from the input. The input
 should be valid Brainfuck code with balanced square brackets,
 followed by the exclamation sign. The output is minified code as one
 line without non-command characters

 Memory layout is:
 [case flag][char][char copy]

 Code starts here:]
read char and subtract exclamation mark (33)
,----- ----- ----- ----- ----- ----- ---
[ restore the char
 +++++ +++++ +++++ +++++ +++++ +++++ +++
 [>+>+<<-] duplicate the char
 +> set case flag
 [ plus (43)
  ----- ----- ----- -----
  ----- ----- ----- ----- ---
  [ comma (44)
   -
   [ minus (45)
    -
    [ period (46)
     -
     [ less than (60)
      ----- ----- ----
      [ more than (62)
       --
       [ opening bracket (91)
        ----- ----- ----- ----- ----- ----
        [ closing bracket (93)
         --
         default: kill the char and case flag and copy
         [<->[-]>[-]<]
         command case: kill flag
         <[-]>]
        command case: kill flag
        <[-]>]
       command case: kill flag
       <[-]>]
      command case: kill flag
      <[-]>]
     command case: kill flag
     <[-]>]
    command case: kill flag
    <[-]>]
   command case: kill flag
   <[-]>]
  command case: kill flag
  <[-]>]
 >[.[-]] print and kill the copy
 read a new char and subtract exclamation mark
 <<,----- ----- ----- ----- ----- ----- ---]

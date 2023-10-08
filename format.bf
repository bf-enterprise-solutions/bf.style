[SPDX-FileCopyrightText: Brainfuck Enterprise Solutions
 SPDX-License-Identifier: WTFPL]
[format.bf---Brainfuck code formatter.

 Much like gofmt, formats the Brainfuck code it reads in the only
 formatting way possible: bf.style one. The input should be valid
 Brainfuck code with balanced square brackets, followed by the
 exclamation sign. The output is properly formatted code.

 Memory layout is:
 [^bracket count] [case flag] [char] [char copy]

 Code starts here:]

read char and subtract exclamation mark (33)
>>,----- ----- ----- ----- ----- ----- ---
[ restore the initial char and print it
 +++++ +++++ +++++ +++++ +++++ +++++ +++.
 <+> set case flag
 [ ----- ----- newline (10)
  [ opening bracket (91)
   ----- ----- ----- -----
   ----- ----- ----- -----
   ----- ----- ----- -----
   ----- ----- ----- ----- -
   [ -- closing bracket (93)
    default: kill the char and case flag
    [[-]<->]
    case closing bracket: kill flag and decrease bracket count
    <[-<->]>
   ]
   case opening bracket: kill flag and increase bracket count
   <[-<+>]>
  ]
  <[ case newline:
   reuse the case flag and search for non space chars
   [>,-- ----- ----- ----- ----- ----- -----
    when non space restore and copy it and kill the flag
    [+++++ +++++ +++++ +++++ +++++ +++++ ++ [>+<-] <->]<]
   SPECIAL CASE: closing bracket starting the line
   + set flag
   subtract closing bracket
   >>--- ----- ----- ----- ----- ----- -----
   ----- ----- ----- ----- ----- -----
   ----- ----- ----- ----- ----- -----
   [ if not closing bracket
    <<- kill the flag
    > ++ +++++ +++++ +++++ +++++ +++++ +++++ space (for printing)
    <<[>+>.<<-] to bracket count and print bracket count (minus one) spaces
    >[<+>-] restore bracket count
    >[-] remove space
    >[<+>-] copy the non bracket for later move
   ]
   restore the closing bracket
   +++++ +++++ +++++ +++++ +++++ +++++
   +++++ +++++ +++++ +++++ +++++ +++++
   +++++ +++++ +++++ +++++ +++++ +++++ +++
   <[>+<-] if it was copied above then move it back
   <[ if closing bracket case
    - kill the flag
    > ++ +++++ +++++ +++++ +++++ +++++ +++++ space (for printing)
    <<-[>+>.<<-] to bracket count and print bracket count minus one spaces
    >+[<+>-] restore bracket count
    >[-]< delete space and back to flag
   ]
  ]>
 ]
 <+ set the 'needs reading' flag
 copy the copied char closer if already read
 and kill the 'needs reading' flag
 >>[<<->>[<+>-]]
 <<[->,<] read new char if 'needs reading'
 subtract exclamation mark
 > --- ----- ----- ----- ----- ----- -----
]

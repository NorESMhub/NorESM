Coding guidelines for HAMOCC
============================

These guidelines are based in part on the
NEMO coding guidelines, the «Fortran Coding Standards and Style» by The
Fortran Company and the current HAMOCC (and MICOM) code.
These recommendations are *guidelines* to ease the life of the
user, developer and computer, on short to long term. This set of
recommendations is not a proposal to rewrite MICOM/HAMOCC. It is rather
meant to be considered when modifying or extending the code.
A discussion about applying similar guidelines to MICOM and NorESM would
be useful.

Modal verbs are used roughly as in RFC 2119.

Coding guidelines
-----------------

-  The code is to be written in Fortran 95, which is---rather than a
   completely new version---mostly a *clarification* of Fortran 90. When
   useful, features from newer Fortran versions may be used but never
   features from beyond Fortran 2008. Moreover, compiler-specific
   features that are not part of any Fortran standard must not be used.
-  Prefer readable/maintainable code over efficient code.
-  All subroutines and functions must include an IMPLICIT NONE
   statement.
-  All dummy arguments (in subroutines and functions) must have their
   intent declared.
-  All functions should be pure such that they have no side effects. For
   instance, ``pure function square(x)`` will only return the square of
   ``x`` and does not change ``x`` or any other variable. In addition,
   all dummy arguments of a pure function must be declared
   ``intent(in)``.
-  Local arguments should be declared separate from the list of dummy
   arguments (e.g. by putting a blank line after the dummy argument
   declaration and/or indicating this with a comment).
-  Modules should be used instead of obsolescent common blocks
   (typically in header files).
-  Indentation should be 3 spaces. We don't use tab characters---rather
   set your editor that hitting Tab corresponds to 3-space indentation.
   However, embedded ``do i =``, ``do j =``, ... loops are are allowed
   without relative indentation (historical coding style).
-  Each ``use`` statement is recommended to have an ``only`` clause to
   identify the source of the used variables and to limit the number of
   side effects.
-  For floating point (real) types, Fortran 95 kind types should be
   used, namely ``real(kind=wp)``. See ``mo_kind.F90`` for the kinds
   that we use (and update if needed).
-  Use logical variables for flags, not integers (and certainly not
   reals).
-  The variable and data type should be separated with two colons (::).
-  The variable that is declared should have all attributes in the
   declaration line.
-  A variable declaration should be followed by a comment explaining
   what the variable is, for instance
   ``real, dimension(:,:), allocatable ::   myvar !: This is a description of myvar``.
-  All variables should be in lower case and self-explanatory; use
   underscores (\_) if this improves readability.
-  All keywords should be in lower case as well. However, some things
   like C pre-processor keys and namelist variables may be capitalised.
   Even though Fortran is not case-sensitive, you must not use different
   case for different instances of the same variable, subroutine or
   function name.
-  Free-form source is used. Lines must never be longer than 90
   characters. You may impose a shorter limit on yourself if you want
   to. Continuation is done with ampersands (&) at both the end of the
   line and start of the continued line (after a standard 3-character
   indentation). The ampersands will be aligned.
-  The more modern ``==`` should be used instead of ``.eq.`` etc.
-  Routine argument lists should contain a maximum of 5 variables per
   line, whilst continuation lines can be used. This applies both to the
   calling routine and the dummy argument list in the routine being
   called. The argument sublist per continuation line must be consistent
   between the calling routine and the dummy argument list.
-  ``#ifdef``\ s and ``#if defined()`` directives should be avoided.
-  When using an embedded construct with such directives, indent with
   one space but leave the ``#`` at the start of the line, thus
   ``# ifdef``, ``#  ifdef`` etc.
-  Use comments where useful. However, code should be readable without
   the comments.
-  When in doubt, ask a collegue what they does or would do.
-  It is often a good idea to ask a collegue to audit (a part of) your
   code.

There are more things that could be specified (like having spaces around
``=`` or wether to write ``end do`` or ``enddo``), but many of those I
left out because it can be left to the programmer in question who also
wants to conform as much as possible to the existing code they is
modifying.

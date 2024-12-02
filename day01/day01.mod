(*
 * Build with Turbo Modula 2 for CP/M.
 * Tested on MSX-DOS/Nextor.
 *
 * SPDX-License-Identifier: MIT
 * vim:ft=modula2:
 *)

MODULE Day01;

FROM ComLine IMPORT commandLine;
FROM Files IMPORT EndError;
FROM Texts IMPORT TEXT, OpenText, CloseText, Done;

CONST
	NumEntries = 1001;

VAR
	f: TEXT;
	inputFileName: ARRAY [0..12] OF CHAR;
	a, b: ARRAY [0..NumEntries] OF LONGINT;
	n: LONGINT;
	i, j: CARDINAL;

(*
 * Naïve, in place insertion sort.
 *)
PROCEDURE Sort(VAR numbers: ARRAY OF LONGINT; size: CARDINAL);
VAR
	i, j: CARDINAL;
	index: LONGINT;
BEGIN
	FOR i := 2 TO size - 1 DO
		index := numbers[i];
		j := i;
		IF i MOD 20 = 0 THEN
			Write('.');
		END;
		WHILE (j > 1) AND (numbers[j - 1] > index) DO
			numbers[j] := numbers[j - 1];
			DEC(j);
		END;
		numbers[j] := index;
	END;
END Sort;

PROCEDURE Parse;
BEGIN
	i := 0;
	LOOP
		Read(f, n);
		IF Done(f) THEN
			a[i] := n;
			Read(f, n);
			IF NOT Done(f) THEN
				WriteLn('Could not read second number in the line');
				HALT;
			END;
			b[i] := n;
			INC(i);
			IF i >= NumEntries THEN
				WriteLn('Tried to read more than ', NumEntries, ' entries');
				HALT;
			END;
			IF i MOD 20 = 0 THEN
				Write('.');
			END;
		END;
	END;
EXCEPTION
	EndError: WriteLn(' ', i:0, ' entries');
END Parse;

BEGIN
	Read(commandLine, inputFileName);
	IF inputFileName = '' THEN
		WriteLn('No input file specified');
		HALT;
	END;
	IF NOT OpenText(f, inputFileName) THEN
		WriteLn('Could not open "', inputFileName, '"');
		HALT;
	END;
	Write('Reading.');
	Parse;
	CloseText(f);

	Write('Sorting A');
	Sort(a, i); WriteLn(' Done.');
	Write('Sorting B');
	Sort(b, i); WriteLn(' Done.');

	Write('Mulling.');
	n := 0L;
	FOR j := 0 TO i - 1 DO
		n := n + ABS(a[j] - b[j]);
		IF j MOD 20 = 0 THEN
			Write('.');
		END;
	END;
	WriteLn(' ', n:0);
END Day01.

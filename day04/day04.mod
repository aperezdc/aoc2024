(*
 * Build with Turbo Modula 2 for CP/M.
 * Tested on MSX-DOS/Nextor.
 *
 * SPDX-License-Identifier: MIT
 * vim:ft=modula2:
 *)

MODULE Day04;

FROM ComLine IMPORT commandLine;
FROM Texts IMPORT TEXT, OpenText, CloseText, Done;

TYPE
	Directions = (Right, Left, Down, Up, RightDown, LeftDown, RightUp, LeftUp);

CONST
	NumRows = 150;
	NumCols = 150;

VAR
	inputFileName: ARRAY [0..15] OF CHAR;
	result: CARDINAL;
	nRows, nCols: CARDINAL;
	row, col: CARDINAL;
	sx, sy: INTEGER;
	d: Directions;
	board: ARRAY [0..NumRows],[0..NumCols] OF CHAR;
	f: TEXT;
	XMAS: ARRAY [0..3] OF CHAR;

PROCEDURE StepX(d: Directions): INTEGER;
BEGIN
	CASE d OF
	| Right:     RETURN  1
	| Left:      RETURN -1
	| RightDown: RETURN  1
	| LeftDown:  RETURN -1
	| RightUp:   RETURN  1
	| LeftUp:    RETURN -1
	ELSE
		RETURN 0;
	END;
END StepX;

PROCEDURE StepY(d: Directions): INTEGER;
BEGIN
	CASE d OF
	| Down:      RETURN  1
	| Up:        RETURN -1
	| RightDown: RETURN  1
	| LeftDown:  RETURN  1
	| RightUp:   RETURN -1
	| LeftUp:    RETURN -1
	ELSE
		RETURN 0;
	END;
END StepY;

PROCEDURE Parse;
VAR
	ch: CHAR;
	col: CARDINAL;
BEGIN
	nRows := 0;
	col := 0;
	LOOP
		Read(f, ch);

		IF ch = CHR(26) THEN
			EXIT;
		END;

		IF ch = CHR(10) THEN
			IF nCols = 0 THEN
				nCols := col;
			ELSIF nCols <> col THEN
				WriteLn;
				WriteLn('Expected ', nCols:0, ' columns, got ', col:0);
				HALT;
			END;
			col := 0;
			INC(nRows);
			IF nRows > NumRows THEN
				WriteLn;
				WriteLn('Tried to read more than ', NumRows:0, ' lines');
				HALT;
			END;
			IF nRows MOD 10 = 0 THEN
				Write('.');
			END;
		ELSE
			IF col >= NumCols THEN
				WriteLn;
				WriteLn('Tried to read more than ', NumCols:0, ' columns');
			END;
			board[nRows][col] := ch;
			INC(col);
		END
	END;
	WriteLn(' ', nRows:0, 'x', nCols:0, ' entries');
END Parse;

PROCEDURE isXMAS(row: CARDINAL; col: CARDINAL; sx: INTEGER; sy: INTEGER): BOOLEAN;
VAR
	di: INTEGER;
	letter: CHAR;
	x, y: INTEGER;
BEGIN
	FOR di := 0 TO 3 DO
		letter := XMAS[di];
		x := (di * sx);
		y := (di * sy);
		INC(x, col);
		INC(y, row);

		IF (x < 0) OR (y < 0) THEN RETURN FALSE END;
		IF (x >= INT(nCols)) THEN RETURN FALSE END;
		IF (y >= INT(nRows)) THEN RETURN FALSE END;
		IF (board[y][x] <> letter) THEN RETURN FALSE END;
	END;
	RETURN TRUE;
END isXMAS;

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

	XMAS[0] := 'X';
	XMAS[1] := 'M';
	XMAS[2] := 'A';
	XMAS[3] := 'S';

	Write('Mulling.');
	result := 0;
	FOR row := 0 TO nRows - 1 DO
		IF row MOD 10 = 0 THEN Write('.') END;
		FOR col := 0 TO nCols - 1 DO
			FOR d := MIN(Directions) TO MAX(Directions) DO
				sx := StepX(d);
				sy := StepY(d);
				IF isXMAS(row, col, sx, sy) THEN
					INC(result);
				END;
			END;
		END;
	END;
	WriteLn(' ', result:0);
END Day04.

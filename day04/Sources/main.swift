// SPDX-License-Identifier: MIT

var board: [[UInt8]] = []

while let line = readLine(strippingNewline: true) {
    if line.isEmpty {
        break
    }
    board.append(Array(line.utf8))
}

let rows = board.count
let cols = board[0].count
print("Board size: \(rows)x\(cols)")

let directions = [
    ( 1,  0), // Right
    (-1,  0), // Left
    ( 0,  1), // Down
    ( 0, -1), // Up
    ( 1,  1), // Right-Down
    (-1,  1), // Left-Down
    ( 1, -1), // Right-Up
    (-1, -1), // Left-Up
]

let asciiX = UInt8(ascii: "X")
let asciiM = UInt8(ascii: "M")
let asciiA = UInt8(ascii: "A")
let asciiS = UInt8(ascii: "S")

let XMAS: [UInt8] = [
    asciiX,
    asciiM,
    asciiA,
    asciiS,
]

@MainActor
func isXMAS(position: (Int, Int), step: (Int, Int)) -> Bool
{
    let (col, row) = position
    let (sx, sy) = step

    for (di, letter) in XMAS.enumerated() {
        let x = col + (di * sx)
        let y = row + (di * sy)

        if x < 0 || y < 0 || x >= cols || y >= rows || board[y][x] != letter {
            return false
        }
    }

    return true
}

// S.M
// .A.
// S.M
let SM_SM = [asciiS, asciiM, asciiS, asciiM]

// M.S
// .A.
// M.S
let MS_MS = [asciiM, asciiS, asciiM, asciiS]

// S.S
// .A.
// M.M
let SS_MM = [asciiS, asciiS, asciiM, asciiM]

// M.M
// .A.
// S.S
let MM_SS = [asciiM, asciiM, asciiS, asciiS]

let CrossMASCombinations = [SM_SM, MS_MS, SS_MM, MM_SS]


@MainActor
func isCrossMAS(position: (Int, Int)) -> Bool
{
    let (col, row) = position

    if col < 1 || row < 1 || col >= (cols - 1) || row >= (rows - 1) {
        return false
    }

    // There must be an "A" always in the middle
    if board[row][col] != asciiA {
        return false
    }

    let thisCombo = [board[row-1][col-1], board[row-1][col+1],
                     board[row+1][col-1], board[row+1][col+1]]

    for combo in CrossMASCombinations {
        if thisCombo == combo {
            return true
        }
    }

    return false
}

var numXMAS = 0
var numCrossMAS = 0
for row in 0...board.count-1 {
    assert(cols == board[row].count)
    for col in 0...cols-1 {
        for directionStep in directions {
            if isXMAS(position: (col, row), step: directionStep) {
                numXMAS += 1
            }
        }
        if isCrossMAS(position: (col, row)) {
            numCrossMAS += 1
        }
    }
}

print("Part 1: \(numXMAS)")
print("Part 2: \(numCrossMAS)")

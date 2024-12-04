// SPDX-License-Identifier: MIT

var board: [[UInt8]] = []

while let line = readLine(strippingNewline: true) {
    if line.isEmpty {
        break
    }
    board.append(Array(line.utf8))
}

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

let rows = board.count
let cols = board[0].count
print("Board size: \(rows)x\(cols)")

let XMAS: [UInt8] = [
    UInt8(ascii: "X"),
    UInt8(ascii: "M"),
    UInt8(ascii: "A"),
    UInt8(ascii: "S"),
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

var result = 0
for row in 0...board.count-1 {
    assert(cols == board[row].count)
    for col in 0...cols-1 {
        for directionStep in directions {
            if isXMAS(position: (col, row), step: directionStep) {
                result += 1
            }
        }
    }
}

print("Result: \(result)")

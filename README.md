# Advent of Code 2025 - D

Solutions for [Advent of Code 2025](https://adventofcode.com/2025) in the D programming language.

## Prerequisites

Install the D compiler and dub package manager:

- **Linux (Debian/Ubuntu):** `sudo apt install dmd dub`
- **macOS:** `brew install dmd dub`
- **Windows:** Download from [dlang.org](https://dlang.org/download.html)
- **Other:** See [D installation guide](https://dlang.org/download.html)

## Project Structure

```
.
├── source/
│   ├── app.d          # Main runner
│   ├── utils.d        # Common utilities
│   └── day01.d-day25.d  # Daily solutions
├── input/
│   └── day01.txt-day25.txt  # Puzzle inputs
└── dub.json           # Package configuration
```

## Usage

### Build and Run

```bash
# Build the project
dub build

# Run a specific day
dub run -- --day 1

# Run a specific day and part
dub run -- --day 1 --part 1

# Run all days
dub run -- --all

# Use custom input file
dub run -- --day 1 --input myinput.txt
```

### Quick Run (without building)

```bash
# Run directly with rdmd (useful for development)
rdmd --compiler=dmd -I=source source/app.d -- --day 1
```

### Running Tests

```bash
# Run unit tests for all modules
dub test
```

## Adding Your Solutions

1. Download your puzzle input from [adventofcode.com](https://adventofcode.com/2025)
2. Save it to `input/dayXX.txt` (e.g., `input/day01.txt`)
3. Edit `source/dayXX.d` and implement `part1` and `part2` functions
4. Run with `dub run -- --day XX`

## Utility Functions

The `utils.d` module provides common helpers:

```d
import utils;

// Parse input
string[] lines = input.lines;           // Split into lines
char[][] g = input.grid;                // 2D character grid
string[] parts = input.groups;          // Split by blank lines
long[] nums = "1 -2 3".ints;            // Extract integers [-2, 1, 3]

// 2D Points
auto p = Point(3, 4);
p.manhattan();                          // Manhattan distance from origin
p.neighbors4();                         // 4-directional neighbors
p.neighbors8();                         // 8-directional neighbors
p.inBounds(width, height);              // Bounds checking

// Directions
Dir.N, Dir.E, Dir.S, Dir.W              // Cardinal directions
DIRS[Dir.N]                             // Direction vectors
turnLeft(Dir.E)                         // Turn counter-clockwise
turnRight(Dir.E)                        // Turn clockwise

// Math
gcd(12, 8)                              // Greatest common divisor: 4
lcm(4, 6)                               // Least common multiple: 12
[2, 3, 4].lcm                           // LCM of range: 12
```

## Tips

- Use `std.algorithm` and `std.range` for functional-style solutions
- D's compile-time features (`static foreach`, CTFE) can help with code generation
- The `std.regex` module is useful for parsing complex inputs
- Use `unittest` blocks in each day file for testing with example inputs

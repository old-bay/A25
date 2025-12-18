module utils;

import std.algorithm;
import std.array;
import std.conv;
import std.range;
import std.string;
import std.typecons;

/// Read input as lines
string[] lines(string input)
{
    return input.splitLines.array;
}

/// Read input as a grid of characters
char[][] grid(string input)
{
    return input.lines.map!(l => l.dup).array;
}

/// Parse all integers from a string
long[] ints(string s)
{
    import std.regex : regex, matchAll;
    auto r = regex(r"-?\d+");
    return s.matchAll(r).map!(m => m.hit.to!long).array;
}

/// Parse all unsigned integers from a string
ulong[] uints(string s)
{
    import std.regex : regex, matchAll;
    auto r = regex(r"\d+");
    return s.matchAll(r).map!(m => m.hit.to!ulong).array;
}

/// Split input into groups separated by blank lines
string[] groups(string input)
{
    return input.split("\n\n").array;
}

/// 2D Point structure
struct Point
{
    long x, y;

    Point opBinary(string op)(Point other) const
        if (op == "+" || op == "-")
    {
        mixin("return Point(x " ~ op ~ " other.x, y " ~ op ~ " other.y);");
    }

    Point opBinary(string op)(long scalar) const
        if (op == "*")
    {
        return Point(x * scalar, y * scalar);
    }

    long manhattan(Point other = Point(0, 0)) const
    {
        import std.math : abs;
        return abs(x - other.x) + abs(y - other.y);
    }

    /// Get 4-directional neighbors (up, down, left, right)
    Point[4] neighbors4() const
    {
        return [
            Point(x, y - 1),  // up
            Point(x, y + 1),  // down
            Point(x - 1, y),  // left
            Point(x + 1, y),  // right
        ];
    }

    /// Get 8-directional neighbors (including diagonals)
    Point[8] neighbors8() const
    {
        return [
            Point(x - 1, y - 1), Point(x, y - 1), Point(x + 1, y - 1),
            Point(x - 1, y),                      Point(x + 1, y),
            Point(x - 1, y + 1), Point(x, y + 1), Point(x + 1, y + 1),
        ];
    }

    /// Check if point is within bounds
    bool inBounds(long width, long height) const
    {
        return x >= 0 && x < width && y >= 0 && y < height;
    }
}

/// Cardinal directions
enum Dir { N, E, S, W }

immutable Point[4] DIRS = [
    Point(0, -1),  // N
    Point(1, 0),   // E
    Point(0, 1),   // S
    Point(-1, 0),  // W
];

/// Turn left (counter-clockwise)
Dir turnLeft(Dir d)
{
    return cast(Dir)((d + 3) % 4);
}

/// Turn right (clockwise)
Dir turnRight(Dir d)
{
    return cast(Dir)((d + 1) % 4);
}

/// Greatest common divisor
long gcd(long a, long b)
{
    import std.math : abs;
    a = abs(a);
    b = abs(b);
    while (b != 0)
    {
        auto t = b;
        b = a % b;
        a = t;
    }
    return a;
}

/// Least common multiple
long lcm(long a, long b)
{
    return (a / gcd(a, b)) * b;
}

/// LCM for a range of numbers
long lcm(R)(R range) if (isInputRange!R)
{
    return range.fold!lcm(1L);
}

/// Simple memoization wrapper
auto memoize(alias func)()
{
    alias Args = Parameters!func;
    alias Ret = ReturnType!func;
    Ret[Args] cache;

    return (Args args) {
        if (auto p = args in cache)
            return *p;
        auto result = func(args);
        cache[args] = result;
        return result;
    };
}

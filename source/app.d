import std.stdio;
import std.conv : to;
import std.getopt;
import std.format : format;

// Import all day modules
import day01, day02, day03, day04, day05;
import day06, day07, day08, day09, day10;
import day11, day12, day13, day14, day15;
import day16, day17, day18, day19, day20;
import day21, day22, day23, day24, day25;

alias SolveFunc = string function(string);

// Registry of solution functions
immutable SolveFunc[2][25] solutions = [
    [&day01.part1, &day01.part2],
    [&day02.part1, &day02.part2],
    [&day03.part1, &day03.part2],
    [&day04.part1, &day04.part2],
    [&day05.part1, &day05.part2],
    [&day06.part1, &day06.part2],
    [&day07.part1, &day07.part2],
    [&day08.part1, &day08.part2],
    [&day09.part1, &day09.part2],
    [&day10.part1, &day10.part2],
    [&day11.part1, &day11.part2],
    [&day12.part1, &day12.part2],
    [&day13.part1, &day13.part2],
    [&day14.part1, &day14.part2],
    [&day15.part1, &day15.part2],
    [&day16.part1, &day16.part2],
    [&day17.part1, &day17.part2],
    [&day18.part1, &day18.part2],
    [&day19.part1, &day19.part2],
    [&day20.part1, &day20.part2],
    [&day21.part1, &day21.part2],
    [&day22.part1, &day22.part2],
    [&day23.part1, &day23.part2],
    [&day24.part1, &day24.part2],
    [&day25.part1, &day25.part2],
];

void main(string[] args)
{
    int day = 0;
    int part = 0;
    bool runAll = false;
    string inputFile = null;

    auto helpInfo = getopt(
        args,
        "day|d", "Day to run (1-25)", &day,
        "part|p", "Part to run (1 or 2, default: both)", &part,
        "all|a", "Run all days", &runAll,
        "input|i", "Custom input file", &inputFile,
    );

    if (helpInfo.helpWanted)
    {
        defaultGetoptPrinter(
            "Advent of Code 2025 - D Solutions\n\n" ~
            "Usage: aoc [options]\n",
            helpInfo.options
        );
        return;
    }

    if (runAll)
    {
        foreach (d; 1 .. 26)
            runDay(d, 0, null);
    }
    else if (day >= 1 && day <= 25)
    {
        runDay(day, part, inputFile);
    }
    else
    {
        writeln("Please specify a day (1-25) with --day or -d, or use --all");
        writeln("Use --help for more options");
    }
}

void runDay(int day, int part, string inputFile)
{
    import std.file : readText, exists;
    import std.string : strip;
    import std.datetime.stopwatch : StopWatch, AutoStart;

    string input;
    string defaultPath = format("input/day%02d.txt", day);
    string path = inputFile ? inputFile : defaultPath;

    if (!exists(path))
    {
        writefln("Day %02d: Input file not found (%s)", day, path);
        return;
    }

    input = readText(path).strip;
    writefln("=== Day %02d ===", day);

    auto sw = StopWatch(AutoStart.no);

    if (part == 0 || part == 1)
    {
        sw.reset();
        sw.start();
        string result1 = solutions[day - 1][0](input);
        sw.stop();
        writefln("Part 1: %s (%.3f ms)", result1, sw.peek.total!"usecs" / 1000.0);
    }

    if (part == 0 || part == 2)
    {
        sw.reset();
        sw.start();
        string result2 = solutions[day - 1][1](input);
        sw.stop();
        writefln("Part 2: %s (%.3f ms)", result2, sw.peek.total!"usecs" / 1000.0);
    }

    writeln();
}

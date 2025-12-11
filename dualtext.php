<?php

$origPath = $argv[1];
$convPath = $argv[2];

$origLines = file($origPath, FILE_IGNORE_NEW_LINES);
$convLines = file($convPath, FILE_IGNORE_NEW_LINES);

$title = basename($convPath, '.txt');

echo "<!doctype html>\n"; 
echo "<html>\n";
echo "<meta charset=\"utf-8\">\n";
echo "<style>\n";
echo "details { margin-bottom: 0.5em; }\n";
echo "summary { cursor: pointer; }\n";
echo "</style>\n";
echo "<body>\n";
echo "<h1>{$title}</h1>\n";

$max = max(count($origLines), count($convLines));

for ($i = 0; $i < $max; $i++) {
    $origLine = $origLines[$i] ?? '';
    $convLine = $convLines[$i] ?? '';

    echo "<details>\n";
    echo "<summary>{$convLine}</summary>\n";
    echo "<pre>{$origLine}</pre>\n";
    echo "</details>\n\n";
}

echo "</body>\n";
echo "</html>\n";
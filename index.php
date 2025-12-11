<?php
header ('Cache-Control: no-store');

$allowedExts = ['html', 'txt'];
$ignore = ['index.php', '.htacess'];

$texts = [];
foreach (scandir(__DIR__)as $file)
{
    if ($file [0] === '.') continue;
    if (in_array($file, $ignore, true)) continue;
    $ext = pathinfo ($file, PATHINFO_EXTENSION);
    if (!in_array($ext, $allowedExts, true )) continue;
    $texts [] = ['name' => $file];
}
?>


<!doctype html><meta charset="utf-8">
<h1>This is my O'odham directory</h1>
<h2>Research Projects</h2>
- <a href="maph.pdf">Switch-Reference Marking</a><br>
<h3>O'odham Texts</h3>
- <a href="html/">HTML Versions</a><br>
- <a href="txt/">TXT Versions</a><br>
#! /usr/bin/perl
# po4a-gettextize tester.

#########################

use strict;
use warnings;

use lib q(t);
use Testhelper;

my @tests;

my $diff_pod_flags = " -I 'This file was generated by po4a' ";

# msginit annoyances, see https://github.com/mquinson/po4a/issues/338
my $PODIFF =
    "-I'^\"Project-Id-Version:' -I'^\"POT-Creation-Date:' -I'^\"PO-Revision-Date:' "
  . "-I'^# [^[:blank:]]* translations for ' -I'^# Language [^[:blank:]]* translations for ' -I'Copyright (C) 20.. Free Software Foundation, Inc.' -I'^# This file is distributed under the same license as the' -I'^# Automatically generated, 20...' ";

$PODIFF .= " -I ^#:";

push @tests,
  {
    'run' =>
      "cd tmp ; perl ../../po4a-gettextize -f text -o markdown -m ../gettextize/test_ok.md -l ../gettextize/TEST_OK.md -p ./generated.po 2> ./err",
    'tests' => [ "diff $PODIFF -u tmp/generated.po gettextize/test_ok.po", "diff -u gettextize/test_ok.err tmp/err" ],
    'doc'   => "Gettextize a simple file.",
  },
  {
    'run' =>
      "cd tmp ; perl ../../po4a-gettextize -f text -o markdown -m ../gettextize/test_dups.md -l ../gettextize/TEST_OK.md -p ./generated.po 2> ./err",
    'tests' =>
      [ "diff $PODIFF -u tmp/generated.po gettextize/test_dups.po", "diff -u gettextize/test_dups.err tmp/err" ],
    'doc' => "Gettextize a file with dupplicate entries.",
  };

run_all_tests(@tests);
0;

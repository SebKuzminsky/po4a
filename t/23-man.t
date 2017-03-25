#! /usr/bin/perl
# Man module tester.

#########################

use strict;
use warnings;

my @tests;

my @formats=qw(man);

mkdir "t/tmp" unless -e "t/tmp";

my $diff_pod_flags= " -I 'This file was generated by po4a' ";

# Quotes (4 tests)
push @tests, {
  'run'  => "perl ../po4a-gettextize -f #format# -m data-23/quotes -p tmp/quotes.pot 2>/dev/null",
  'test' => "perl compare-po.pl data-23/quotes.pot tmp/quotes.pot",
  'doc'  => "gettextize well various quotes",
}, {
  'run'  => "cp data-23/quotes.fr.po tmp/ && chmod u+w tmp/quotes.fr.po".
        " && perl ../po4a-updatepo -f #format# -m data-23/quotes -p tmp/quotes.fr.po >/dev/null 2>&1 ",
  'test' => "perl compare-po.pl data-23/quotes.fr.po tmp/quotes.fr.po",
  'doc'  => "updatepo for this document",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/quotes -p data-23/quotes.fr.po -l tmp/quotes.fr",
  'test' => "diff -u $diff_pod_flags data-23/quotes.fr tmp/quotes.fr",
  'doc'  => "translate this document",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/quoted-comment -p data-23/quotes.fr.po -l tmp/quoted-comment.fr",
  'test' => "diff -u $diff_pod_flags data-23/quoted-comment tmp/quoted-comment.fr",
  'doc'  => "Check that comment markers are not messed up during translation",
};

# Dots (9 tests)
push @tests, {
  'run'  => "perl ../po4a-gettextize -f #format# -m data-23/dot1 -p tmp/dot1.pot 2>/dev/null",
  'test' => "perl compare-po.pl data-23/dot1.pot tmp/dot1.pot",
  'doc'  => "gettextize well various lines beginning by a dot (1)",
}, {
  'run'  => "cp data-23/dot1.fr.po tmp/ && chmod u+w tmp/dot1.fr.po".
        " && perl ../po4a-updatepo -f #format# -m data-23/dot1 -p tmp/dot1.fr.po >/dev/null 2>&1 ",
  'test' => "perl compare-po.pl data-23/dot1.fr.po tmp/dot1.fr.po",
  'doc'  => "updatepo for this document",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/dot1 -p data-23/dot1.fr.po -l tmp/dot1.fr",
  'test' => "diff -u $diff_pod_flags data-23/dot1.fr tmp/dot1.fr",
  'doc'  => "translate this document",
}, {
  'run'  => "LC_ALL=C COLUMNS=80 perl ../po4a-gettextize -f #format# -m data-23/dot2 -p tmp/dot2.pot 2>tmp/dot2.err || true",
  'test' => "perl compare-po.pl data-23/dot2.err tmp/dot2.err",
  'doc'  => "gettextize well various lines beginning by a dot (2)",
  'requires' => "Text::WrapI18N",
}, {
  'run'  => "LC_ALL=C COLUMNS=80 perl ../po4a-gettextize -f #format# -m data-23/dot3 -p tmp/dot3.pot 2>tmp/dot3.err || true",
  'test' => "perl compare-po.pl data-23/dot3.err tmp/dot3.err",
  'doc'  => "gettextize well various lines beginning by a dot (3)",
  'requires' => "Text::WrapI18N",
}, {
  'run'  => "LC_ALL=C COLUMNS=80 perl ../po4a-gettextize -f #format# -m data-23/dot4 -p tmp/dot4.pot 2>tmp/dot4.err || true",
  'test' => "perl compare-po.pl data-23/dot4.err tmp/dot4.err",
  'doc'  => "gettextize well various lines beginning by a dot (4)",
  'requires' => "Text::WrapI18N",
}, {
  'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/dot5 -p tmp/dot5.pot 2>/dev/null",
  'test' => "perl compare-po.pl data-23/dot5.pot tmp/dot5.pot",
  'doc'  => "gettextize well various lines beginning by a dot (5)",
}, {
  'run'  => "cp data-23/dot5.it.po tmp/ && chmod u+w tmp/dot5.it.po".
        " && perl ../po4a-updatepo -f #format# -m data-23/dot5 -p tmp/dot5.it.po >/dev/null 2>&1 ",
  'test' => "perl compare-po.pl data-23/dot5.it.po tmp/dot5.it.po",
  'doc'  => "updatepo for this document",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/dot5 -p data-23/dot5.it.po -l tmp/dot5.it",
  'test' => "diff -u $diff_pod_flags data-23/dot5.it tmp/dot5.it",
  'doc'  => "translate this document",
};

# Null argument (3 tests)
push @tests, {
  'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/null -p tmp/null.pot 2>/dev/null",
  'test' => "perl compare-po.pl data-23/null.pot tmp/null.pot",
  'doc'  => "gettextize well null argument/paragraphs",
}, {
  'run'  => "cp data-23/null.fr.po tmp/ && chmod u+w tmp/null.fr.po".
        " && perl ../po4a-updatepo -f #format# -m data-23/null -p tmp/null.fr.po >/dev/null 2>&1 ",
  'test' => "perl compare-po.pl data-23/null.fr.po tmp/null.fr.po",
  'doc'  => "updatepo for this document",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/null -p data-23/null.fr.po -l tmp/null.fr",
  'test' => "diff -u $diff_pod_flags data-23/null.fr tmp/null.fr",
  'doc'  => "translate this document",
};

# Escaped tabs and newlines (3 tests)
push @tests, {
  'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/escapes1 -p tmp/escapes1.pot 2>/dev/null",
  'test' => "perl compare-po.pl data-23/escapes1.pot tmp/escapes1.pot",
  'doc'  => "gettextize well escaped newlines and tabs",
}, {
  'run'  => "cp data-23/escapes1.it.po tmp/ && chmod u+w tmp/escapes1.it.po".
        " && perl ../po4a-updatepo -f #format# -m data-23/escapes1 -p tmp/escapes1.it.po >/dev/null 2>&1 ",
  'test' => "perl compare-po.pl data-23/escapes1.it.po tmp/escapes1.it.po",
  'doc'  => "updatepo for this document",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/escapes1 -p data-23/escapes1.it.po -l tmp/escapes1.it",
  'test' => "diff -u $diff_pod_flags data-23/escapes1.it tmp/escapes1.it",
  'doc'  => "translate this document",
};

# Fonts
push @tests, {
  'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/fonts -p tmp/fonts.pot",
  'test' => "perl compare-po.pl data-23/fonts.pot tmp/fonts.pot",
  'doc'  => "gettextize well fonts",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/fonts -p data-23/fonts.en.po -l tmp/fonts.en",
  'test' => "diff -u $diff_pod_flags data-23/fonts.en tmp/fonts.en",
  'doc'  => "translate this document",
};

# mdoc format
push @tests, {
    'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/mdoc.1 -p tmp/mdoc.pot 2>/dev/null",
    'test' => "perl compare-po.pl data-23/mdoc.pot tmp/mdoc.pot",
    'doc'  => "gettextize well mdoc",
}, {
    'run'  => "perl ../po4a-translate -f #format# -m data-23/mdoc.1 -p data-23/mdoc.fr.po -l tmp/mdoc.fr -L ISO-8859-1",
    'test' => "diff -u $diff_pod_flags data-23/mdoc.fr tmp/mdoc.fr",
    'doc'  => "translate this document",
};

# tbl format
push @tests, {
    'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/tbl-textblock.1 -p tmp/tbl-textblock.pot 2>/dev/null",
    'test' => "perl compare-po.pl data-23/tbl-textblock.pot tmp/tbl-textblock.pot",
    'doc'  => "Right handling of text blocs in tbl macros",
}, {
    'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/tbl-option-tab.1 -p tmp/tbl-option-tab.pot 2>/dev/null",
    'test' => "perl compare-po.pl data-23/tbl-option-tab.pot tmp/tbl-option-tab.pot",
    'doc'  => "Handle tab option in tab macros",
}, {
    'run'  => "perl ../po4a-translate -f #format# -m data-23/tbl-option-tab.1 -p data-23/tbl-option-tab.fr.po -l tmp/tbl-option-tab.fr.1",
    'test' => "diff -u $diff_pod_flags data-23/tbl-option-tab.fr.1 tmp/tbl-option-tab.fr.1",
    'doc'  => "translate this document",
};

# Mixed mdoc and roff format
push @tests, {
    'run'  => "cp data-23/mixed.fr.po tmp/ && chmod u+w tmp/mixed.fr.po && LC_ALL=C perl ../po4a data-23/mixed.cfg",
    'test' => "perl compare-po.pl data-23/mixed.pot tmp/mixed.pot &&".
              "perl compare-po.pl data-23/mixed.fr.po tmp/mixed.fr.po &&".
              "perl compare-po.pl data-23/mixed1.fr tmp/mixed1.fr &&".
              "perl compare-po.pl data-23/mixed2.fr tmp/mixed2.fr &&".
              "perl compare-po.pl data-23/mixed3.fr tmp/mixed3.fr &&".
              "perl compare-po.pl data-23/mixed4.fr tmp/mixed4.fr",
    'doc'  => "mixed config with roff and mdoc"
};

# Non breaking spaces (7 tests)
push @tests, {
  'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/spaces -p tmp/spaces.pot 2>/dev/null",
  'test' => "perl compare-po.pl data-23/spaces.pot tmp/spaces.pot",
  'doc'  => "gettextize well non breaking spaces",
}, {
  'run'  => "cp data-23/spaces.fr_latin1.po tmp/ && chmod u+w tmp/spaces.fr_latin1.po".
        " && perl ../po4a-updatepo -f #format# -m data-23/spaces -p tmp/spaces.fr_latin1.po >/dev/null 2>&1 ",
  'test' => "perl compare-po.pl data-23/spaces.fr_latin1.po tmp/spaces.fr_latin1.po",
  'doc'  => "updatepo for this document (fr ISO-8859-1)",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/spaces -p data-23/spaces.fr_latin1.po -l tmp/spaces.fr_latin1",
  'test' => "diff -u $diff_pod_flags data-23/spaces.fr_latin1 tmp/spaces.fr_latin1",
  'doc'  => "translate this document (fr ISO-8859-1)",
}, {
  'run'  => "cp data-23/spaces.fr_utf8.po tmp/ && chmod u+w tmp/spaces.fr_utf8.po".
        " && perl ../po4a-updatepo -f #format# -m data-23/spaces -p tmp/spaces.fr_utf8.po >/dev/null 2>&1 ",
  'test' => "perl compare-po.pl data-23/spaces.fr_utf8.po tmp/spaces.fr_utf8.po",
  'doc'  => "updatepo for this document (fr UTF-8)",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/spaces -p data-23/spaces.fr_utf8.po -l tmp/spaces.fr_utf8",
  'test' => "diff -u $diff_pod_flags data-23/spaces.fr_utf8 tmp/spaces.fr_utf8",
  'doc'  => "translate this document (fr UTF-8)",
}, {
  'run'  => "cp data-23/spaces.ja.po tmp/ && chmod u+w tmp/spaces.ja.po".
        " && perl ../po4a-updatepo -f #format# -m data-23/spaces -p tmp/spaces.ja.po >/dev/null 2>&1 ",
  'test' => "perl compare-po.pl data-23/spaces.ja.po tmp/spaces.ja.po",
  'doc'  => "updatepo for this document (ja EUC-JP)",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/spaces -p data-23/spaces.ja.po -l tmp/spaces.ja",
  'test' => "diff -u $diff_pod_flags data-23/spaces.ja tmp/spaces.ja",
  'doc'  => "translate this document (ja EUC-JP)",
};

# Hyphens (4 tests)
push @tests, {
  'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/hyphens.1 -p tmp/hyphens.pot -o groff_code=verbatim 2>/dev/null",
  'test' => "perl compare-po.pl data-23/hyphens.verbatim.pot tmp/hyphens.pot",
  'doc'  => "gettextize well hyphens (verbatim)",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/hyphens.1 -p data-23/hyphens.verbatim.fr.po -l tmp/hyphens.fr -o groff_code=verbatim",
  'test' => "diff -u $diff_pod_flags data-23/hyphens.verbatim.fr tmp/hyphens.fr",
  'doc'  => "translate this document",
}, {
  'run'  => "LC_ALL=C perl ../po4a-gettextize -f #format# -m data-23/hyphens.1 -p tmp/hyphens.pot -o groff_code=translate 2>/dev/null",
  'test' => "perl compare-po.pl data-23/hyphens.translate.pot tmp/hyphens.pot",
  'doc'  => "gettextize well hyphens (translate)",
}, {
  'run'  => "perl ../po4a-translate -f #format# -m data-23/hyphens.1 -p data-23/hyphens.translate.fr.po -l tmp/hyphens.fr -o groff_code=translate",
  'test' => "diff -u $diff_pod_flags data-23/hyphens.translate.fr tmp/hyphens.fr",
  'doc'  => "translate this document",
};

use Test::More tests => 76; # $formats * $tests * 2

foreach my $format (@formats) {
    for (my $i=0; $i<scalar @tests; $i++) {
        chdir "t" || die "Can't chdir to my test directory";

        my ($val,$name);

        my $cmd=$tests[$i]{'run'};
        $cmd =~ s/#format#/$format/g;
        $val=system($cmd);

        $name=$tests[$i]{'doc'}.' runs';
        $name =~ s/#format#/$format/g;
        SKIP: {
            if (defined $tests[$i]{'requires'}) {
                skip ($tests[$i]{'requires'}." required for this test", 1)
                    unless eval 'require '.$tests[$i]{'requires'};
            }
            ok($val == 0,$name);
            diag($cmd) unless ($val == 0);
        }

        SKIP: {
            if (defined $tests[$i]{'requires'}) {
                skip ($tests[$i]{'requires'}." required for this test", 1)
                    unless eval 'require '.$tests[$i]{'requires'};
            }
            skip ("Command don't run, can't test the validity of its return",1)
              if $val;
            my $testcmd=$tests[$i]{'test'};
            $testcmd =~ s/#format#/$format/g;

            $val=system($testcmd);
            $name=$tests[$i]{'doc'}.' returns what is expected';
            $name =~ s/#format#/$format/g;
            ok($val == 0,$name);
            unless ($val == 0) {
                diag ("Failed (retval=$val) on:");
                diag ($testcmd);
                diag ("Was created with:");
                diag ("perl -I../lib $cmd");
            }
        }

#    system("rm -f tmp/* 2>&1");

        chdir ".." || die "Can't chdir back to my root";
    }
}

0;


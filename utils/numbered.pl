use strict;
use warnings;
use feature 'unicode_strings';
use utf8;

binmode(STDOUT, ":utf8");

my %num = (
    "Óenmc" => 1,
    "Dá" => 2,
    "Trí" => 3,
    "Cethri" => 4,
    "Cóic" => 5,
    "Sé" => 6,
    "Secht" => 7,
    "Ocht" => 8,
    "Noí" => 9,
    "Deich" => 10
    );

my $str = $ARGV[0];

my ($head, $tail) = split /:|\s+\.i\.\s+/, $str;

my ($numChild, $person) = split /\sm\s|\smc\s|\s\.?m\.?\s|\smeic\s/, $head;

my $person_no_space = $person =~ s/\s+//gr;

my $output = "<#$person_no_space>\n a foaf:Person;\nirishRel:genName \"$person\";\nirishRel:numChild " . $num{$numChild} . ".\n\n";

my @children = split /\set\s|&|,|\.|ocus/, $tail;

foreach my $child (@children) {
    $child =~ s/^\s+|\s+$//g;
    my $child_no_space = $child =~ s/\s+//gr;
    my $person_space_removed = $person =~ s/\s+//gr;
    $output .= "<#$child_no_space>\n a foaf:Person;\nirishRel:nomName \"$child\";\nrel:childOf <#$person_space_removed>.\n\n";
}

print $output;

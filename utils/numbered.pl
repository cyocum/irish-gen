use strict;
use warnings;

my %num = (
    "Óenmc" => 1,
    "Dá" => 2,
    "Trí" => 3,
    "Cethri" => 4,
    "Cóic" => 5,
    "Sé" => 6,
    "Secht" => 7,
    "Ocht" => 8,
    "Noí" => 9
    );

my $str = $ARGV[0];

my ($head, $tail) = split /:|\s+\.i\.\s+/, $str;

my ($numChild, $person) = split /\sm\s|\smc\s|\s\.?m\.?\s|\smeic\s/, $head;

my $output = "<#$person>\n a foaf:Person;\nirishRel:genName \"$person\";\nirishRel:numChild " . $num{$numChild} . ".\n\n";

my @children = split /\set\s|&|,|\./, $tail;

foreach my $child (@children) {
    $child =~ s/^\s+|\s+$//g;
    $output .= "<#$child>\n a foaf:Person;\nirishRel:nomName \"$child\";\nrel:childOf <#$person>.\n\n";
}

print $output;

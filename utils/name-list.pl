use strict;
use warnings;

my $str = $ARGV[0];

my @individuals = split(/\sm\s|\smc\s|\s\.?m\.?\s|\singen\s|\singine\s|\smeic\s/, $str);
my $output = '';

my $len = @individuals;

my %seen;

for(my $i = 0; $i < $len; $i++) {
    my $person = $individuals[$i];

    my $relationship = '';

    my $next = $individuals[$i+1];

    if($next) {
	$relationship = ";\nrel:childOf <#$next>.\n\n";
    } else { $relationship = "."; }

    $output .= "<#$person>\na foaf:Person;\n";
    
    if($i == 0) {
	$output .= "irishRel:nomName \"$person\"";
    } else  {
	$output .= "irishRel:genName \"$person\"";
    }
    
    $output .= $relationship;
}

print $output;


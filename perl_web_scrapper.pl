use strict;
use warnings;
use LWP::Simple qw(get);

#the link to fetch the data
my $url = "https://www.rivm.nl/en/coronavirus-map-netherlands-per-municipality";

#Get data from the link
my $html = get $url;

#Split the html data on new line
my @arr = split('\n', $html);  
#no of lines
my $len = @arr;

#output file
open(my $fh1, '>', "www/cases.csv") or die "Could not open file 'cases.csv' $!";
open(my $fh2, '>', "www/cases.txt") or die "Could not open file 'cases.txt' $!";

print $fh1 "Municipality,Cases,Cases/100k\n";
print $fh2 "Municipality\tCases\tCases/100k\n";

#iterating over each line
for(my $i=0; $i<$len; $i++)
{
	if($arr[$i] =~ m/[0-9]+;.+;.+;.+;.+/)		#finding the lines with the pattern
	{
		my @a = split(';', $arr[$i]);
		s{'}{}g foreach @a;
		print $fh1 "$a[1],$a[2],$a[4]\n";
		print $fh2 "$a[1]\t$a[2]\t$a[4]\n";
	}
}


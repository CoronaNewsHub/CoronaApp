use strict;
use warnings;
use LWP::Simple qw(get);

#the link to fetch the data
#my $url = "https://www.rivm.nl/en/coronavirus-map-netherlands-per-municipality";
my $url = "https://www.rivm.nl/en/current-information-about-novel-coronavirus-covid-19";

#Get data from the link
my $html = get $url;

#Split the html data on new line
my @arr = split('\n', $html);  
#no of lines
my $len = @arr;
#print "@arr";
#output file
open(my $fh1, '>', "www/cases.csv") or die "Could not open file 'cases.csv' $!";
open(my $fh2, '>', "www/cases.txt") or die "Could not open file 'cases.txt' $!";

print $fh1 "Municipality,Cases,Cases/100k\n";
print $fh2 "Municipality\tCases\tCases/100k\n";

my @num;

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
	elsif($arr[$i] =~ m/<p><span class="h3">/)
	{
		my $val = $arr[$i];
		$val =~ s/\<p\>|\<\/p\>|\<span class="h3"\>|\<\/span\>|\*//gi;
		push @num, $val;
	}
}

my @v_names = ("Positive tested persons", "Admitted to hospital", "Reported deaths");
#print "@num\n";

open(my $fh3, '>', "www/numbers.txt") or die "Could not open file 'numbers.txt' $!";
print $fh3 "Attribute\tValue\n";

for(my $i=0; $i<=$#num; $i++)
{
	print $fh3 "$v_names[$i]\t$num[$i]\n";
}


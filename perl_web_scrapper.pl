use strict;
use warnings;
use LWP::Simple qw(get);
use DateTime;
use Time::Piece;
print "Entered\n";
my $url = "https://www.rivm.nl/en/current-information-about-novel-coronavirus-covid-19";

#Get data from the link
my $html = get $url;

#Split the html data on new line
my @arr = split('\n', $html);  
#print "@arr\n";

#no of lines
my $len = @arr;

#output file
open(my $fh1, '>', "www/cases.csv") or die "Could not open file 'cases.csv' $!";
open(my $fh2, '>', "www/cases.txt") or die "Could not open file 'cases.txt' $!";

print $fh1 "Municipality,Cases,Hospitalization,Deaths,Population,Cases per 100k,Hospitalization per 100k,Deaths per 100k\n";
print $fh2 "Municipality\tCases\tHospitalization\tDeaths\tPopulation\tCases per 100k\tHospitalization per 100k\tDeaths per 100k\n";

my @num;

#iterating over each line
for(my $i=0; $i<$len; $i++)
{
#	print "$arr[$i]\n";
	
	if($arr[$i] =~ m/[0-9]+;.+;.+;.+;.+/)		#finding the lines with the pattern
	{
#		$arr[$i] =~ s/data\-columns\=|\"//gi;
		
		my @a = split(';', $arr[$i]);
		s{'|,}{}g foreach @a;
		
		if($arr[$i] =~ m/data\-columns\=|\"/)
		{
			print "Hello\n";
		}
		else
		{
			shift @a;
			my $cases1 = join ",", @a;
			my $cases2 = join "\t", @a;
			
			print $fh1 "$cases1\n";
			print $fh2 "$cases2\n";
			
	#		print $fh1 "$a[1],$a[3],$a[6],$a[2],$a[5]\n";
	#		print $fh2 "$a[1]\t$a[3]\t$a[6]\t$a[2]\t$a[5]\n";
		}
	}
	elsif($arr[$i] =~ m/<h4>/)
	{
		my $val = $arr[$i];
		$val =~ s/\<h4\>|\<\/h4\>|\s|\*+|\(.+\)|\,//gi;
		$val =~ s/<span>|<\/span>//gi;
		push @num, $val;
	}

}

my @v_names = ("Positive tested persons", "Admitted to hospital", "Reported deaths");

open(my $fh3, '>', "www/numbers.txt") or die "Could not open file 'numbers.txt' $!";
print $fh3 "Attribute\tValue\n";

for(my $i=0; $i<=$#num; $i++)
{
	print $fh3 "$v_names[$i]\t$num[$i]\n";
#	print "$v_names[$i]\t$num[$i]\n";
}

#Data for timeline
my @milestones = ("5000000", "1000000", "500000", "100000", "50000", "10000", "5000", "1000", "500", "100", "50", "1");

#to read
my $filename1 = 'www/milestone_cases.txt';
open(my $readfh1, $filename1) or die "Could not open file '$filename1' $!";
chomp(my @cases = <$readfh1>);

close $readfh1;

#to write; append
open(my $fh4, '>>', $filename1) or die "Could not open file '$filename1' $!";

my @a = split /,/, $cases[$#cases];	#last line of the file

for(my $i=0; $i<=$#milestones; $i++)
{
	if($a[0] == $milestones[$i])		#$num : positive cases
	{
		if($num[0] > $milestones[$i-1])
		{
			my $date = localtime->strftime('%m/%d/%Y');
			print $fh4 "\n$milestones[$i-1],$date";
#			print "$milestones[$i-1],$date\n";
			last;
		}
	}
}



#to read
my $filename2 = 'www/milestone_deaths.txt';
open(my $readfh2, $filename2) or die "Could not open file '$filename2' $!";
chomp(my @deaths = <$readfh2>);

close $readfh2;

#to write; append
open(my $fh5, '>>', $filename1) or die "Could not open file '$filename2' $!";

@a = split /,/, $deaths[$#deaths];	#last line of the file

for(my $i=0; $i<=$#milestones; $i++)
{
	if($a[0] == $milestones[$i])		#$num : positive cases
	{
		if($num[0] > $milestones[$i-1])
		{
			my $date = localtime->strftime('%m/%d/%Y');
			print $fh5 "\n$milestones[$i-1],$date";
#			print "$milestones[$i-1],$date\n";
			last;
		}
	}
}



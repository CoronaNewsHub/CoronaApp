use strict;
use warnings;
#!/usr/bin/Rscript

while(1 == 1)
{
	my $t = localtime();
	print "\n===============================\nStarted at: $t\n===============================\n\n";
	my @a = split /\s/, $t;
	my @arr = split /:/, $a[4];

	if($arr[0] >= 3 && $arr[0] <= 16)		#run only between 2 and 5 pm CEST
	{
#		print "Entered\n";
		#run perl prog for webscrapping
		system("perl perl_web_scrapper.pl");
		
		#run make graph prog
		system(`"C:/Program Files/R/R-3.6.3/bin/Rscript.exe" graphs.r`);
	}

	#run rss feed script; runs after every 60 minutes (depending on time defined in sleep function)
	system(`"C:/Program Files/R/R-3.6.3/bin/Rscript.exe" rss_feed_extraction.r`);
	
	sleep(60);
	
	system("perl git.pl");
	sleep(7000);
}
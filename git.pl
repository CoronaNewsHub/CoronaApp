use strict;
use warnings;

my $cmd1 = "git add .";
system($cmd1);

my $cmd2 = "git status";
system($cmd2);

my $cmd3 = "git commit -am \"Updates\"";
system($cmd3);

my $cmd4 = "git push";
system($cmd4);

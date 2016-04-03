---
title: Perl Demo
date: 2016-02-11 23:12:07
categories: open-source
tags: [Perl]
---


### install tutorial

> Perl install

> sudo apt-get update

> sudo apt-get upgrade

> sudo apt-get install -y perl

> perl -version

- my $secstr = join("\t\t",@items2[1...$#items2]);


- perl example:

``` bash
#!/usr/bin/perl -w
die "perl $0 perl infile1 infile2 > outfile.xls\n" unless @ARGV == 2;
$infile1 = shift;
$infile2 = shift;
print "ID\tP1_counts\tP2_counts\n";
my %data;
open IN, $infile1 or die $!;
while(<IN>){
	chomp;
	my @items = split /\s+\/;
	my $str = $items[1];
	$data{$items[0]} = $str;
}
close IN;
my $str1 = 0;
# print "$str1\n";
open IN, $infile2 or die $!;
while(<IN>){
	chomp;
	my @items2 = split /\s+/;
	my $str2 = $items2[1];
	if($data{$items2[0]}){
		print "$items2[0]\t$data{$items2[0]}\t$str2\n";
		delete $data{$items2[0]};
	}else{
		print "$items2[0]\t$str1\t$str2\n";
		delete $data{$items2[0]};
	}
}
close IN;
foreach my $chr (keys %data){
	print "$chr\t$data{$chr}\t$str1\n";
}
# output combine to files
#open COMBINE, "> tmp.xls" or die "Unable to create combine file : $!";
#foreach (sort keys %data){

	# COMBINE $data{$itesm[0]}{$items[1]},"\n";
#}
#close COMBINE;

```

> How to split array in perl file

``` bash
        my $datetime = $items2[5];
#       my @straing = split /[-\s:]+/, $datatime;
        my @time = split(/[[:space:]]+/,$datetime);
        my @day = split(/-/,$time[0]);
        my @hr = split(/:/,$time[1]);
```


Question: If there is 10g file data 10g, but there are a lot of row is duplicated and need to merge the duplicate rows with a line, there are two ways to achieve. [Ref](http://www.jb51.net/article/34992.htm)

  - cat data |sort|uniq > new_data # cost too much time

  - A small tool processed by perl.

``` bash
#!/usr/bin/perl
use warnings;
use strict;
# creat a hash, each raw as a key value, then using the number of each line to fill the key value.

 my %hash;
my $script = $0; # Get the script name
 sub usage
{
        printf("Usage:\n");
        printf("perl $script <source_file> <dest_file>\n");
 }
 # If the number of parameters less than 2 ,exit the script
if ( $#ARGV+1 < 2) {
         &usage;
        exit 0;
}

my $source_file = $ARGV[0]; #File need to remove duplicate rows
my $dest_file = $ARGV[1]; # File after remove duplicates rows
 open (FILE,"<$source_file") or die "Cannot open file $!\n";
open (SORTED,">$dest_file") or die "Cannot open file $!\n";
 while(defined (my $line = <FILE>))
{
        chomp($line);
        $hash{$line} += 1;
        # print "$line,$hash{$line}\n";
}
 foreach my $k (keys %hash) {
        print SORTED "$k,$hash{$k}\n"; #change the line and print out the col, as well as the number of col to objective file
}
close (FILE);
close (SORTED);
```


### Regular Expression

``` bash
str="this is a string"
# estimate if the character "this" is contained in str, using the following statement

[[ $str =~ "this" ]] && echo "\$str contains this"
[[ $str =~ "that" ]] || echo "\$str does NOT contain this"
```
> judge symbol "[["
> match symbol "=~"

#!/usr/bin/perl
#
#

use GD;
use CGI qw(param);
use CGI;

print "Content-type: image/gif\n\n";

$in_url=CGI->new->url();


if (param()) {
	$username = param("user");
	$filename = param("file");
	$picfile = param("pic");
	$temp = "0";

        $picfullfile = "$picfile$temp.gif";

        open (SRC,$picfullfile) || Error_handler ("$picfullfile has a problem.");
        $srcim = newFromGif GD::Image(SRC) || die; 
        close SRC;
	@temp = $srcim->getBounds();

	$picwidth = $temp[0];
	$picheight = $temp[1];
	$fullfilename = "doc";

	open (USERDATA, $fullfilename) || Error_handler ("$fullfilename has a problem.");
	$count = <USERDATA>;
	$ipexempt = <USERDATA>;
	chomp ($count);
	chomp ($ipexempt);
	close USERDATA;

	$ipaddr = $ENV{'REMOTE_ADDR'};

	if ($ipaddr ne $ipexempt) {
		++$count;
		$fullfilename = ">$fullfilename";
		open (USERDATA, $fullfilename) || die;
		print USERDATA "$count\n";
		print USERDATA "$ipexempt\n";
		close USERDATA;
	}

	$len = length $count;
	$fullwidth = $len * $picwidth;

	$im = new GD::Image($fullwidth,$picheight) || die;
	$black = $im->colorAllocate(0,0,0);
	$im->transparent($black);
	$im->fill(10,10,$black);

	while ($count ne "") {
		$current_char = chop($count);
		$x = (--$len) * $picwidth;

		$picfullfile = "$picfile$current_char.gif";

		open (SRC,$picfullfile) || die;
		$srcim = newFromGif GD::Image(SRC) || die;
		close SRC;

		$im->copy($srcim,$x,0,0,0,$picwidth,$picheight);
	}	

} else {

	Error_handler("No variables specified? http://dt_counter.pl?user=xxx&file=xxx&pic=xxx");
}


print $im->gif;

sub Error_handler {

	$errormsg = $_[0];
	$im = new GD::Image(500,32) || die;
	$black = $im->colorAllocate(0,0,0);
	$white = $im->colorAllocate(255,255,255);
	$im->transparent($black);
	$im->fill(10,10,$black);
	$im->string(gdSmallFont,0,0,$errormsg,$white);
	print $im->gif;
	die;
	

}


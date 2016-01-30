#!/usr/bin/perl
#
#

use GD;
use CGI qw(param);
use CGI;

#print "Content-type: image/gif\n\n";
print "Content-type: text/html\n\n";

$in_url=CGI->new->url();

print $in_url;

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


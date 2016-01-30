#!/usr/bin/perl
#

#use CGI qw(param);
use CGI;
use Data::Dumper;

print "Content-type: text/html\n\n";

$in_url=CGI->new->url();
$in_server=CGI->new->server_name();
$repo_owner = param("repo_owner");
$repo_name = param("repo_name");
$repo_branch = param("repo_branch");

print "$in_url<br>";
print "$in_server<br>";
print "$repo_owner<br>";
print "$repo_name<br>";
print "$repo_branch<br>";

print "https://api.github.com/repos/$repo_owner/$repo_name/status/$repo_branch<br>";

$response = `set -x;curl -q -k "https://api.github.com/repos/$repo_owner/$repo_name/status/$repo_branch" | jq '.state'`;

print "|$response|<br>";

@temp = split /"/, $response;
$response = $temp[1];

print Dumper(@test);

$redirect_url="http://doc.tavian.com/build-unknown-yellow.svg";
if ($response eq "pending") { $redirect_url = "http://doc.tavian.com/build-pending-yellow.svg"; }
if ($response eq "failure") { $redirect_url = "http://doc.tavian.com/build-failure-red.svg"; }
if ($response eq "error") { $redirect_url = "http://doc.tavian.com/build-error-red.svg"; }
if ($response eq "success") { $redirect_url = "http://doc.tavian.com/build-success-green.svg"; }

print "$redirect_url<br>";

print "Location: $redirect_url\n\n";

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


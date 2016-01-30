#!/usr/bin/perl
#

use CGI qw(param);
use CGI;
use Data::Dumper;

print "Content-type: text/html\n\n";

$in_url=CGI->new->url();
$in_server = $ENV{SERVER_NAME};
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

$redirect_url="http://$in_server/build-unknown-yellow.svg";

if ($response eq "pending") { $redirect_url = "http://$in_server/build-pending-yellow.svg"; }
if ($response eq "failure") { $redirect_url = "http://$in_server/build-failure-red.svg"; }
if ($response eq "error") { $redirect_url = "http://$in_server/build-error-red.svg"; }
if ($response eq "success") { $redirect_url = "http://$in_server/build-success-green.svg"; }

print "$redirect_url<br>";

print "Location: $redirect_url\n\n";


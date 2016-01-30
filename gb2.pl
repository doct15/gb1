#!/usr/bin/perl
#

use CGI qw(param);
use CGI;
use Data::Dumper;



$in_url=CGI->new->url();
$in_server = $ENV{SERVER_NAME};
$repo_owner = param("repo_owner");
$repo_name = param("repo_name");
$repo_branch = param("repo_branch");









$response = `curl -q -k "https://api.github.com/repos/$repo_owner/$repo_name/status/$repo_branch" | jq '.state'`;



@temp = split /"/, $response;
$response = $temp[1];



$timer_var=time;
$redirect_url="http://$in_server/build-unknown-yellow.svg?sig=$timer_var";

if ($response eq "pending") { $redirect_url = "http://$in_server/build-pending-yellow.svg?sig=$timer_var"; }
if ($response eq "failure") { $redirect_url = "http://$in_server/build-failure-red.svg?sig=$timer_var"; }
if ($response eq "error") { $redirect_url = "http://$in_server/build-error-red.svg?sig=$timer_var"; }
if ($response eq "success") { $redirect_url = "http://$in_server/build-success-green.svg?sig=$timer_var"; }



print "Location: $redirect_url\n\n";


#!/usr/bin/perl
#
#

use CGI qw(param);
use CGI;
use Data::Dumper;

$in_url=CGI->new->url();
$in_server=CGI->new->server_name();
$repo_owner = param("repo_owner");
$repo_name = param("repo_name");
$repo_branch = param("repo_branch");

$response = `curl -q -k "https://api.github.com/repos/$repo_owner/$repo_name/status/$repo_branch" | jq '.state'`;

@temp = split /"/, $response;
$response = $temp[1];

$redirect_url="http://doc.tavian.com/build-unknown-yellow.svg";

if ($response eq "pending") { $redirect_url = "http://doc.tavian.com/build-pending-yellow.svg"; }
if ($response eq "failure") { $redirect_url = "http://doc.tavian.com/build-failure-red.svg"; }
if ($response eq "error") { $redirect_url = "http://doc.tavian.com/build-error-red.svg"; }
if ($response eq "success") { $redirect_url = "http://doc.tavian.com/build-success-green.svg"; }

print "Location: $redirect_url\n\n";


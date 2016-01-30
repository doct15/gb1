#!/usr/bin/perl
#

use CGI qw(param);
use CGI qw(:standard);
use CGI;
use Data::Dumper;
use POSIX qw(strftime);

$timer_var=time;

print header(
    # date in the past
    -expires       => 'Sun, 3 Jan 2016 05:00:00 GMT',
    # always modified
    -Last_Modified => strftime('%a, %d %b %Y %H:%M:%S GMT', gmtime),
    # HTTP/1.0
    -Pragma        => 'no-cache',
    #-ETag          => "$timer_var",
    # HTTP/1.1 + IE-specific (pre|post)-check
    -Cache_Control => join(', ', qw(
        private
        no-cache
        no-store
        must-revalidate
        max-age=0
        pre-check=0
        post-check=0
    )),
);



$in_url=CGI->new->url();
$in_server = $ENV{SERVER_NAME};
$repo_owner = param("repo_owner");
$repo_name = param("repo_name");
$repo_branch = param("repo_branch");









$response = `curl -q -k "https://api.github.com/repos/$repo_owner/$repo_name/status/$repo_branch" | jq '.state'`;



@temp = split /"/, $response;
$response = $temp[1];



$redirect_url="http://$in_server/build-unknown-yellow.svg?sig=$timer_var";

if ($response eq "pending") { $redirect_url = "http://$in_server/build-pending-yellow.svg?sig=$timer_var"; }
if ($response eq "failure") { $redirect_url = "http://$in_server/build-failure-red.svg?sig=$timer_var"; }
if ($response eq "error") { $redirect_url = "http://$in_server/build-error-red.svg?sig=$timer_var"; }
if ($response eq "success") { $redirect_url = "http://$in_server/build-success-green.svg?sig=$timer_var"; }



print "Location: $redirect_url\n\n";


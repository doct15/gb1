#!/usr/bin/perl
#

use CGI qw(param);
use CGI qw(:standard);
use CGI;
use Data::Dumper;
use POSIX qw(strftime);



$in_url=CGI->new->url();
$in_server = $ENV{SERVER_NAME};
$repo_owner = param("repo_owner");
$repo_name = param("repo_name");
$repo_branch = param("repo_branch");









$response = `curl -q -k "https://api.github.com/repos/$repo_owner/$repo_name/status/$repo_branch" | jq '.state'`;



@temp = split /"/, $response;
$response = $temp[1];



$timer_var=time;
$redirect_url="<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"98\" height=\"20\"><linearGradient id=\"b\" x2=\"0\" y2=\"100%\"><stop offset=\"0\" stop-color=\"#bbb\" stop-opacity=\".1\"/><stop offset=\"1\" stop-opacity=\".1\"/></linearGradient><mask id=\"a\"><rect width=\"98\" height=\"20\" rx=\"3\" fill=\"#fff\"/></mask><g mask=\"url(#a)\"><path fill=\"#555\" d=\"M0 0h37v20H0z\"/><path fill=\"#dfb317\" d=\"M37 0h61v20H37z\"/><path fill=\"url(#b)\" d=\"M0 0h98v20H0z\"/></g><g fill=\"#fff\" text-anchor=\"middle\" font-family=\"DejaVu Sans,Verdana,Geneva,sans-serif\" font-size=\"11\"><text x=\"18.5\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">build</text><text x=\"18.5\" y=\"14\">build</text><text x=\"66.5\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">unknown</text><text x=\"66.5\" y=\"14\">unknown</text></g></svg>";

if ($response eq "pending") { $redirect_url = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"92\" height=\"20\"><linearGradient id=\"b\" x2=\"0\" y2=\"100%\"><stop offset=\"0\" stop-color=\"#bbb\" stop-opacity=\".1\"/><stop offset=\"1\" stop-opacity=\".1\"/></linearGradient><mask id=\"a\"><rect width=\"92\" height=\"20\" rx=\"3\" fill=\"#fff\"/></mask><g mask=\"url(#a)\"><path fill=\"#555\" d=\"M0 0h37v20H0z\"/><path fill=\"#dfb317\" d=\"M37 0h55v20H37z\"/><path fill=\"url(#b)\" d=\"M0 0h92v20H0z\"/></g><g fill=\"#fff\" text-anchor=\"middle\" font-family=\"DejaVu Sans,Verdana,Geneva,sans-serif\" font-size=\"11\"><text x=\"18.5\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">build</text><text x=\"18.5\" y=\"14\">build</text><text x=\"63.5\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">pending</text><text x=\"63.5\" y=\"14\">pending</text></g></svg>"; }
if ($response eq "failure") { $redirect_url = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"83\" height=\"20\"><linearGradient id=\"b\" x2=\"0\" y2=\"100%\"><stop offset=\"0\" stop-color=\"#bbb\" stop-opacity=\".1\"/><stop offset=\"1\" stop-opacity=\".1\"/></linearGradient><mask id=\"a\"><rect width=\"83\" height=\"20\" rx=\"3\" fill=\"#fff\"/></mask><g mask=\"url(#a)\"><path fill=\"#555\" d=\"M0 0h37v20H0z\"/><path fill=\"#e05d44\" d=\"M37 0h46v20H37z\"/><path fill=\"url(#b)\" d=\"M0 0h83v20H0z\"/></g><g fill=\"#fff\" text-anchor=\"middle\" font-family=\"DejaVu Sans,Verdana,Geneva,sans-serif\" font-size=\"11\"><text x=\"18.5\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">build</text><text x=\"18.5\" y=\"14\">build</text><text x=\"59\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">failure</text><text x=\"59\" y=\"14\">failure</text></g></svg>"; }
if ($response eq "error") { $redirect_url = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"76\" height=\"20\"><linearGradient id=\"b\" x2=\"0\" y2=\"100%\"><stop offset=\"0\" stop-color=\"#bbb\" stop-opacity=\".1\"/><stop offset=\"1\" stop-opacity=\".1\"/></linearGradient><mask id=\"a\"><rect width=\"76\" height=\"20\" rx=\"3\" fill=\"#fff\"/></mask><g mask=\"url(#a)\"><path fill=\"#555\" d=\"M0 0h37v20H0z\"/><path fill=\"#e05d44\" d=\"M37 0h39v20H37z\"/><path fill=\"url(#b)\" d=\"M0 0h76v20H0z\"/></g><g fill=\"#fff\" text-anchor=\"middle\" font-family=\"DejaVu Sans,Verdana,Geneva,sans-serif\" font-size=\"11\"><text x=\"18.5\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">build</text><text x=\"18.5\" y=\"14\">build</text><text x=\"55.5\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">error</text><text x=\"55.5\" y=\"14\">error</text></g></svg>"; }
if ($response eq "success") { $redirect_url = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"91\" height=\"20\"><linearGradient id=\"b\" x2=\"0\" y2=\"100%\"><stop offset=\"0\" stop-color=\"#bbb\" stop-opacity=\".1\"/><stop offset=\"1\" stop-opacity=\".1\"/></linearGradient><mask id=\"a\"><rect width=\"91\" height=\"20\" rx=\"3\" fill=\"#fff\"/></mask><g mask=\"url(#a)\"><path fill=\"#555\" d=\"M0 0h37v20H0z\"/><path fill=\"#97CA00\" d=\"M37 0h54v20H37z\"/><path fill=\"url(#b)\" d=\"M0 0h91v20H0z\"/></g><g fill=\"#fff\" text-anchor=\"middle\" font-family=\"DejaVu Sans,Verdana,Geneva,sans-serif\" font-size=\"11\"><text x=\"18.5\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">build</text><text x=\"18.5\" y=\"14\">build</text><text x=\"63\" y=\"15\" fill=\"#010101\" fill-opacity=\".3\">success</text><text x=\"63\" y=\"14\">success</text></g></svg>"; }



$timer_var=time;

print header(
    # Content-type
    -type          => 'image/svg+xml',
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
    #-Location => "$redirect_url",
);
print "$redirect_url\n\n";
#print "Location: $redirect_url\n\n";


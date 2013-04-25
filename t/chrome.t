#!perl

use strict;
use warnings;

use Parse::UserAgent;
use Test::More 0.88 tests => 3;

my $ua;
my $parser = Parse::UserAgent->new(use_caching => 1);
ok(defined($parser), 'create parser');

ok(defined($ua = $parser->parse('Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19'))
    && $ua->name eq 'Chrome'
    && $ua->version eq '18.0.1025.133'
    && $ua->version->major == 18
    && $ua->version->minor == 0
    && $ua->os eq 'Android 4.0.4'
    && $ua->os->name eq 'Android'
    && $ua->os->version eq '4.0.4'
    && $ua->os->version->major == 4
    && $ua->os->version->minor == 0
    ,'Chrome 18 on Android 4.0.4');

ok(defined($ua = $parser->parse('Mozilla/5.0 (Windows; U; Windows NT 6.1; de-DE) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.224 Safari/534.10'))
    && $ua->name eq 'Chrome'
    && $ua->version eq '8.0.552.224'
    && $ua->version->major == 8
    && $ua->version->minor == 0
    && $ua->os eq 'Windows 7'
    && $ua->language eq 'German'
    && $ua->language->name eq 'German'
    && $ua->language->code eq 'de-DE'
    ,'Chrome 8 on Windows 7 (German)');


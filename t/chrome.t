#!perl

use strict;
use warnings;

use Parse::UserAgent;
use Test::More 0.88 tests => 2;

my $ua;
my $parser = Parse::UserAgent->new(use_caching => 1);
ok(defined($parser), 'create parser');

ok(defined($ua = $parser->parse('Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19'))
    && $ua->name eq 'Chrome'
    && $ua->version eq '18.0.1025.133'
    && $ua->version->major == 18
    && $ua->version->minor == 0,
    'Chrome 18 on Android 4.0.4');


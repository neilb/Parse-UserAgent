package Parse::UserAgent;

use Parse::UserAgent::UA;
use Moo;

has use_caching => (
    is => 'rw',
    default => sub { 1; },
);

has cache => (
    is => 'rw',
    default => sub { return {}; },
);

sub parse
{
    my $self      = shift;
    my $ua_string = shift;
    my $ua;

    if ($self->use_caching && exists $self->cache->{ $ua_string }) {
        $ua = $self->cache->{ $ua_string };
    } else {
        $ua = Parse::UserAgent::UA->new( ua_string => $ua_string );
        $self->cache->{ $ua_string } = $ua if $self->use_caching;
    }

    return $ua;
}

1;


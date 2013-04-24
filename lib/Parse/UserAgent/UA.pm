package Parse::UserAgent::UA;

use Moo;
use relative -to => 'Parse::UserAgent::UA', -aliased => qw(Name Version);

has ua_string => (is => 'ro');
has name      => (is => 'rwp', lazy => 1, builder => '_build_name');
has version   => (is => 'rwp', lazy => 1, builder => '_build_version');

sub _build_name
{
    my $self = shift;
    my ($name, $version) = $self->_parse_name_and_version();
    $self->_set_version($version);
    return $name;
}

sub _build_version
{
    my $self = shift;
    my ($name, $version) = $self->_parse_name_and_version();
    $self->_set_name($name);
    return $version;
}

sub _parse_name_and_version
{
    my $self = shift;
    my ($name, $version);

    if ($self->ua_string =~ m!\bChrome/((\d+)\.(\d+)\.(\d+)\.(\d+))\b!) {
        $name    = Name->new(raw => 'Chrome', cooked => 'Chrome');
        $version = Version->new( raw => $1, major => $2, minor => $3);
    }

    if ($self->ua_string =~ m!\bMSIE ((\d+)\.(\d+)[\.0-9]*)!) {
        $name    = Name->new(raw => 'MSIE', cooked => 'Internet Explorer');
        $version = Version->new( raw => $1, major => $2, minor => $3);
    }

    return ($name, $version);
}

1;
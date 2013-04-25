package Parse::UserAgent::UA;

use Moo;
use relative -to => 'Parse::UserAgent::UA', -aliased => qw(Name Version OS Language);

has ua_string => (is => 'ro');
has name      => (is => 'rwp', lazy => 1, builder => '_build_name');
has version   => (is => 'rwp', lazy => 1, builder => '_build_version');
has os        => (is => 'rwp', lazy => 1, builder => '_build_os');
has language  => (is => 'rwp', lazy => 1, builder => '_build_language');

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

sub _build_os
{
    my $self = shift;
    my ($name, $version, $os);

    if ($self->ua_string =~ m!Android\s+((\d+)\.(\d+)([\.0-9]*))!) {
        $name    = Name->new(raw => 'Android', cooked => 'Android');
        $version = Version->new(raw => $1, major => $2, minor => $3);
    }

    if ($self->ua_string =~ m!(Windows NT\s*((\d+)(\.\d+)?))!) {
        my $v     = $2;
        my $osraw = $1;
        my $vraw;

        $name = Name->new(raw => 'Windows NT', cooked => 'Windows');

        if ($v >= 6.2) {
            $vraw = '8';
        } elsif ($v >= 6.1) {
            $vraw = '7';
        } elsif ($v >= 6.06) {
            $vraw = 'Server 2008';
        } elsif ($v >= 6.0) {
            $vraw = 'Vista';
        } elsif ($v >= 5.1) {
            $vraw = 'XP';
        } elsif ($v >= 5.0) {
            $vraw = '2000';
        } else {
            $vraw = $v;
        }
        $version = Version->new(raw => $vraw);
        return OS->new(raw => $osraw, name => $name, version => $version);
    }

    if (defined($name) && defined($version)) {
        return OS->new(name => $name, version => $version);
    } else {
        return undef;
    }
}

my %languages =
(
    'de-DE' => 'German',
    'de'    => 'German',
    'en'    => 'English',
    'en-US' => 'US English',
    'en-GB' => 'UK English',
);

sub _build_language
{
    my $self = shift;

    if ($self->ua_string =~ m!\b([a-z][a-z]|[a-z][a-z]-[A-Z][A-Z])[;)]! && exists($languages{$1})) {
        return Language->new(code => $1, name => $languages{$1});
    }
    return undef;
}

1;

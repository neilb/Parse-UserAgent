package Parse::UserAgent::UA::OS;

use Moo;
use overload
    '""'  => sub {
                my ($self, $other, $swap) = @_;
                return $self->fullname;
             },
    'cmp' => sub {
                my ($self, $other, $swap) = @_;
                my $result = $self->fullname cmp $other;
                $result = -$result if $swap;
                return $result;
             };

has raw     => ( is => 'ro');
has name    => ( is => 'ro');
has version => ( is => 'ro');

sub fullname
{
    my $self = shift;
    return $self->name.' '.$self->version;
}


1;

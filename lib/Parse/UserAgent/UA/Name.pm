package Parse::UserAgent::UA::Name;

use Moo;
use overload
    '""'  => sub { $_[0]->cooked(); },
    'cmp' => sub {
                my ($self, $other, $swap) = @_;
                my $result = $self->raw cmp $other;
                $result = -$result if $swap;
                return $result;
             };

has raw    => ( is => 'ro');
has cooked => ( is => 'ro');


1;

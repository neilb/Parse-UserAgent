package Parse::UserAgent::UA::Version;

use Moo;
use overload
    '""'  => sub { $_[0]->raw(); },
    'cmp' => sub {
                my ($self, $other, $swap) = @_;
                my $result = $self->raw cmp $other;
                $result = -$result if $swap;
                return $result;
             };

has raw   => (is => 'ro');
has major => (is => 'ro');
has minor => (is => 'ro');

1;

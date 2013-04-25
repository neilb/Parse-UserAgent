package Parse::UserAgent::UA::Language;

use Moo;
use overload
    '""'  => sub { $_[0]->name(); },
    'cmp' => sub {
                my ($self, $other, $swap) = @_;
                my $result = $self->name cmp $other;
                $result = -$result if $swap;
                return $result;
             };

has name => (is => 'ro');
has code => (is => 'ro');

1;

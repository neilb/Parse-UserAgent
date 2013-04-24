package Parse::UserAgent::UA::Version;

use Moo;
use overload '""' => sub { $_[0]->raw(); };

has raw   => (is => 'ro');
has major => (is => 'ro');
has minor => (is => 'ro');

1;
